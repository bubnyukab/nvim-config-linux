return {
  -- Go development (richer than bare gopls: goimports, test helpers, struct/interface generation)
  {
    "ray-x/go.nvim",
    dependencies = { "ray-x/guihua.lua" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
    config = function()
      require("go").setup()
      -- Import organization on save is handled by null-ls (goimports-reviser).
      -- go.nvim's own BufWritePre autocmd was removed to avoid double-format
      -- and a signature mismatch that triggered an AddImportArgs unmarshal error.
    end,
  },

  -- Go struct-tag helpers, impl/iferr generation, etc.
  -- (Mason installs the underlying CLI tools via :GoInstallDeps)
  {
    "olexsmir/gopher.nvim",
    ft = "go",
    build = function()
      vim.cmd("silent! GoInstallDeps")
    end,
    config = function()
      require("gopher").setup()
      vim.keymap.set("n", "<leader>gsj", "<cmd>GoTagAdd json<cr>", { desc = "Go: add JSON struct tags" })
      vim.keymap.set("n", "<leader>gsy", "<cmd>GoTagAdd yaml<cr>", { desc = "Go: add YAML struct tags" })
    end,
  },

  -- Swagger/OpenAPI preview
  {
    "vinnymeller/swagger-preview.nvim",
    cmd = { "SwaggerPreview", "SwaggerPreviewStop", "SwaggerPreviewToggle" },
    config = function()
      require("swagger-preview").setup({ port = 8765, host = "localhost" })
    end,
  },
}
