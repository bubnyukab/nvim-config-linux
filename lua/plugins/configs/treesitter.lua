require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "lua", "vim", "vimdoc",
    "javascript", "typescript", "tsx",
    "go", "gomod",
    "html", "css", "json", "yaml",
    "markdown", "markdown_inline",
    "bash",
  },
  auto_install = true,
  highlight = { enable = true },
  indent = { enable = true },
})
