return {
  -- Tmux runner used by vim-test (renders test output in a tmux pane next to nvim)
  "preservim/vimux",

  {
    "vim-test/vim-test",
    dependencies = { "preservim/vimux" },
    config = function()
      -- Resolve the project root for the current buffer (go.mod / Cargo.toml /
      -- package.json / .git) and fall back to the buffer's own directory.
      _G.__vim_test_cwd = function()
        local path = vim.api.nvim_buf_get_name(0)
        if path == "" then return vim.fn.getcwd() end
        local root = vim.fs.root(path, { "go.mod", "Cargo.toml", "package.json", ".git" })
        return root or vim.fn.fnamemodify(path, ":p:h")
      end

      -- Custom strategy: cd into the project root in the vimux pane before running.
      -- This makes `:TestNearest` work no matter where nvim was launched from.
      vim.cmd([[
        function! TestVimuxCdStrategy(cmd) abort
          let l:dir = luaeval('_G.__vim_test_cwd()')
          call VimuxRunCommand('cd ' . shellescape(l:dir) . ' && ' . a:cmd)
        endfunction
        let g:test#custom_strategies = { 'vimux_cd': function('TestVimuxCdStrategy') }
      ]])
      vim.g["test#strategy"] = "vimux_cd"

      vim.keymap.set("n", "<leader>tn", "<cmd>TestNearest<cr>", { desc = "Test nearest" })
      vim.keymap.set("n", "<leader>tf", "<cmd>TestFile<cr>",    { desc = "Test file" })
      vim.keymap.set("n", "<leader>ts", "<cmd>TestSuite<cr>",   { desc = "Test suite" })
      vim.keymap.set("n", "<leader>tl", "<cmd>TestLast<cr>",    { desc = "Test last" })
      vim.keymap.set("n", "<leader>tv", "<cmd>TestVisit<cr>",   { desc = "Test visit" })
    end,
  },
}
