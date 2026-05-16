return {
  -- Auto-detect indentation per project (overrides global tabstop/shiftwidth)
  "tpope/vim-sleuth",

  -- Trailing whitespace removal on save
  {
    "cappyzawa/trim.nvim",
    config = function()
      require("trim").setup({ ft_blocklist = { "markdown" } })
    end,
  },

  -- File browser as a buffer; great for quick renames and moves
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        view_options = { show_hidden = true },
        float = { padding = 2 },
      })
      vim.keymap.set("n", "-", "<cmd>Oil --float<cr>", { desc = "Open oil file browser" })
    end,
  },
}
