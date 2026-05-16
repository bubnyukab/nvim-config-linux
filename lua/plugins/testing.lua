return {
  -- Tmux runner used by vim-test (renders test output in a tmux pane next to nvim)
  "preservim/vimux",

  {
    "vim-test/vim-test",
    dependencies = { "preservim/vimux" },
    config = function()
      vim.g["test#strategy"] = "vimux"
      vim.keymap.set("n", "<leader>tn", "<cmd>TestNearest<cr>", { desc = "Test nearest" })
      vim.keymap.set("n", "<leader>tf", "<cmd>TestFile<cr>",    { desc = "Test file" })
      vim.keymap.set("n", "<leader>ts", "<cmd>TestSuite<cr>",   { desc = "Test suite" })
      vim.keymap.set("n", "<leader>tl", "<cmd>TestLast<cr>",    { desc = "Test last" })
      vim.keymap.set("n", "<leader>tv", "<cmd>TestVisit<cr>",   { desc = "Test visit" })
    end,
  },
}
