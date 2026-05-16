local conform = require("conform")

conform.setup({
  -- Per-filetype formatter chains. Multiple entries run in order and pipe output through.
  formatters_by_ft = {
    lua  = { "stylua" },

    -- Web / config files
    javascript     = { "prettier" },
    javascriptreact = { "prettier" },
    typescript     = { "prettier" },
    typescriptreact = { "prettier" },
    css      = { "prettier" },
    html     = { "prettier" },
    json     = { "prettier" },
    yaml     = { "prettier" },
    markdown = { "prettier" },

    -- Go: organize imports → gofumpt (stricter gofmt) → golines (wrap long lines)
    go = { "goimports-reviser", "gofumpt", "golines" },
  },

  -- Format every save. LSP formatting still runs as a fallback for filetypes
  -- not listed above (so e.g. gopls / lua_ls hover-rename hygiene still works).
  format_on_save = {
    timeout_ms = 1000,
    lsp_format = "fallback",
  },
})

-- Manual format keymap (replaces the old <leader>lf in lspconfig).
vim.keymap.set({ "n", "v" }, "<leader>lf", function()
  conform.format({ async = true, lsp_format = "fallback" })
end, { desc = "Format buffer" })
