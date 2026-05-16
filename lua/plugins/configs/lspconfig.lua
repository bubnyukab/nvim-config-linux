local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local opts = { buffer = args.buf }
    vim.keymap.set("n", "gd",         vim.lsp.buf.definition,     opts)
    vim.keymap.set("n", "K",          vim.lsp.buf.hover,          opts)
    vim.keymap.set("n", "gi",         vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action,    opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,         opts)
    vim.keymap.set("n", "gr",         vim.lsp.buf.references,     opts)
    vim.keymap.set("n", "[d",         vim.diagnostic.goto_prev,   opts)
    vim.keymap.set("n", "]d",         vim.diagnostic.goto_next,   opts)
    -- Formatting (<leader>lf) is handled by conform.nvim — see configs/conform.lua
  end,
})

local servers = {
  lua_ls = {
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
      },
    },
  },
  ts_ls         = {},
  html          = {},
  -- solargraph = {}, -- Ruby LSP, re-enable when needed
  rust_analyzer = {},
  gopls = {
    -- Detect Go module / workspace / repo root
    root_markers = { "go.work", "go.mod", ".git" },
    settings = {
      gopls = {
        completeUnimported = true,
        usePlaceholders = true,
        analyses = {
          unusedparams = true,
        },
      },
    },
  },
}

for server, config in pairs(servers) do
  config.capabilities = capabilities
  vim.lsp.config(server, config)
  vim.lsp.enable(server)
end
