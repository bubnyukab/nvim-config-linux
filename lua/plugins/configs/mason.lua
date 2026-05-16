require("mason").setup()

require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "ts_ls",
    "eslint",
    "html",
    "gopls",
    "pyright",
  },
  automatic_installation = true,
})

-- Auto-install formatters and linters on first launch
local ok, registry = pcall(require, "mason-registry")
if ok then
  local tools = {
    "stylua",
    "prettier",
    -- Go: formatters + import organizer + debugger
    "gofumpt",
    "goimports",
    "goimports-reviser",
    "golines",
    "delve",
    -- Python: formatter + linter (ruff) + debugger (debugpy)
    "ruff",
    "debugpy",
  }
  registry.refresh(function()
    for _, tool in ipairs(tools) do
      local pkg_ok, pkg = pcall(registry.get_package, tool)
      if pkg_ok and not pkg:is_installed() then
        pkg:install()
      end
    end
  end)
end
