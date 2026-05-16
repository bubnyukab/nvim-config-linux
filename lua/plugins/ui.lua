return {
  -- Fuzzy finder + file browser
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-telescope/telescope-file-browser.nvim",
    },
    config = function()
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")

      telescope.setup({
        defaults = { path_display = { "smart" } },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
          file_browser = {
            theme = "ivy",
            hijack_netrw = true,
          },
        },
      })

      telescope.load_extension("ui-select")
      telescope.load_extension("file_browser")

      vim.keymap.set("n", "<C-p>", builtin.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
      vim.keymap.set("n", "<leader><leader>", builtin.oldfiles, { desc = "Recent files" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
      vim.keymap.set("n", "<leader>fb", "<cmd>Telescope file_browser<cr>", { desc = "File browser" })
      vim.keymap.set("n", "<leader>fn", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>", { desc = "Browse current dir" })
    end,
  },

  -- Status line: mode | branch+diff | diagnostics ··· filetype | LSP | progress | location
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          globalstatus = true,             -- one statusline across all splits
          section_separators = { left = "", right = "" },
          component_separators = { left = "│", right = "│" },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = {
            "branch",
            { "diff", symbols = { added = " ", modified = " ", removed = " " } },
          },
          lualine_c = {
            {
              "diagnostics",
              sources = { "nvim_diagnostic" },
              symbols = { error = " ", warn = " ", info = " ", hint = " " },
            },
            { "filename", path = 1 },      -- show relative path, not just basename
          },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      })
    end,
  },

  -- Icons
  { "nvim-tree/nvim-web-devicons", lazy = true },

  -- Keybinding popup
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      wk.setup({})
      wk.add({
        { "<leader>f",  group = "Find" },
        { "<leader>g",  group = "Git" },
        { "<leader>gs", group = "Go struct-tags" },
        { "<leader>b",  group = "Buffer" },
        { "<leader>t",  group = "Test" },
        { "<leader>d",  group = "Debug" },
        { "<leader>dg", group = "Debug Go" },
        { "<leader>du", group = "Debug UI" },
      })
    end,
  },

  -- Dashboard
  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      dashboard.section.header.val = {
        "                                                     ",
        "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
        "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
        "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
        "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
        "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
        "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
        "                                                     ",
      }

      dashboard.section.buttons.val = {
        dashboard.button("f", "  Find file", "<cmd>Telescope find_files<cr>"),
        dashboard.button("r", "  Recent files", "<cmd>Telescope oldfiles<cr>"),
        dashboard.button("g", "  Live grep", "<cmd>Telescope live_grep<cr>"),
        dashboard.button("q", "  Quit", "<cmd>qa<cr>"),
      }

      alpha.setup(dashboard.config)
    end,
  },
}
