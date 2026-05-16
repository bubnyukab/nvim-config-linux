return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = true,
        window = { width = 30 },
        filesystem = {
          filtered_items = {
            visible = false,
            hide_dotfiles = false,
            hide_gitignored = false,
          },
        },
      })
      vim.keymap.set("n", "<C-n>", "<cmd>Neotree toggle left<cr>", { desc = "Toggle file tree" })
      vim.keymap.set("n", "<leader>bf", "<cmd>Neotree float<cr>", { desc = "Float file tree" })
    end,
  },
}
