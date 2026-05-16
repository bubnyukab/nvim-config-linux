return {
  -- Gruvbox (closest standalone equivalent of NvChad's "gruvchad" — same palette family,
  -- gruvchad itself is locked inside NvChad's base46 theme cache and not portable).
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        contrast = "hard",        -- "hard" | "medium" | "soft"
        transparent_mode = true,
      })
      vim.cmd.colorscheme("gruvbox")
    end,
  },

  -- Kept as a fallback / alt scheme — lazy-loaded so it doesn't override gruvbox.
  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = true,
    opts = { flavour = "mocha", transparent_background = true },
  },
}
