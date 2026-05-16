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

  -- Fast in-buffer motion: press `s` then 2 chars to jump anywhere visible.
  -- `S` works in operator-pending too (e.g. `dS` to delete to a target).
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,     desc = "Toggle Flash Search" },
    },
  },

  -- Change/add/delete surrounding pairs: `ysiw)` wraps word in parens, `cs"'` swaps quotes, `ds(` deletes.
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end,
  },
}
