return {
  -- Core DAP engine
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- UI overlay (scopes / stacks / breakpoints / repl panes)
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio", -- required by dap-ui
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()

      -- Auto-open / auto-close the dap-ui overlay around debug sessions.
      dap.listeners.before.attach.dapui_config = function() dapui.open() end
      dap.listeners.before.launch.dapui_config = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
      dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

      -- Core keymaps under <leader>d
      vim.keymap.set("n", "<leader>db",  dap.toggle_breakpoint, { desc = "DAP: toggle breakpoint" })
      vim.keymap.set("n", "<leader>dc",  dap.continue,          { desc = "DAP: continue / start" })
      vim.keymap.set("n", "<leader>dus", function() dapui.toggle({ reset = true }) end,
        { desc = "DAP: toggle UI (scopes sidebar)" })
    end,
  },

  -- Go-specific DAP adapter (Delve integration + helpers for nearest/last test)
  {
    "leoluz/nvim-dap-go",
    ft = "go",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("dap-go").setup()
      vim.keymap.set("n", "<leader>dgt", function() require("dap-go").debug_test()      end,
        { desc = "DAP-Go: debug nearest test" })
      vim.keymap.set("n", "<leader>dgl", function() require("dap-go").debug_last_test() end,
        { desc = "DAP-Go: debug last test" })
    end,
  },

  -- Python DAP adapter (debugpy via Mason). Uses Mason's bundled python by default.
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local mason_python = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(mason_python)
      vim.keymap.set("n", "<leader>dpt", function() require("dap-python").test_method()  end,
        { desc = "DAP-Python: debug nearest test method" })
      vim.keymap.set("n", "<leader>dpc", function() require("dap-python").test_class()   end,
        { desc = "DAP-Python: debug test class" })
    end,
  },
}
