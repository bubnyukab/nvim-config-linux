# nvim-config-linux

Personal Neovim configuration. Lua-based, managed by [lazy.nvim], targeting Neovim ≥ 0.11 (uses the native `vim.lsp.config` / `vim.lsp.enable` API).

## Install

```sh
git clone https://github.com/bubnyukab/nvim-config-linux.git ~/.config/nvim
nvim   # lazy.nvim bootstraps itself; Mason installs LSPs/formatters on first run
```

External requirements:

- `git`, `ripgrep` (for Telescope live-grep), a Nerd Font (for icons)
- `go` toolchain (for go.nvim / gopher.nvim / delve)
- `node` (for prettier and TS servers via Mason)

## Layout

```
init.lua                        bootstrap, options, leader, lazy.setup("plugins")
lua/plugins/
├── init.lua                    plenary, vim-tmux-navigator
├── code.lua                    LSP, conform, treesitter, cmp, autopairs, Comment
├── colorscheme.lua             gruvbox (active), catppuccin (fallback)
├── custom.lua                  per-machine overrides (empty placeholder)
├── dap.lua                     nvim-dap + dap-ui + dap-go
├── edit.lua                    vim-sleuth, trim.nvim, oil.nvim
├── filetree.lua                neo-tree
├── git.lua                     fugitive + gitsigns
├── lang.lua                    go.nvim, gopher.nvim, swagger-preview
├── testing.lua                 vim-test + vimux (runs tests in a tmux pane)
├── ui.lua                      telescope, lualine, which-key, alpha
└── configs/
    ├── cmp.lua                 completion mappings + sources
    ├── conform.lua             format-on-save, formatter chains per filetype
    ├── lspconfig.lua           LspAttach keymaps, server configs
    ├── mason.lua               ensure_installed (servers + tools)
    └── treesitter.lua          parser list
```

## Architecture notes

- LSP uses Neovim 0.11 native API (`vim.lsp.config` + `vim.lsp.enable`), not `lspconfig[server].setup{}`.
- Formatting is owned by **conform.nvim** (not none-ls). Format-on-save is enabled; `<leader>lf` is the manual key. LSP formatting is a fallback for filetypes without a configured formatter.
- Go imports are organized by `goimports-reviser` via conform — `go.nvim`'s own BufWritePre hook is intentionally not configured (would double-format).
- Mason auto-installs both LSP servers (via mason-lspconfig `ensure_installed`) and CLI tools (formatters/debuggers, via a `mason-registry` loop in `configs/mason.lua`).

## Editor options (from `init.lua`)

- Leader: `<Space>` (both `mapleader` and `maplocalleader`)
- Line numbers + relative, mouse on, system clipboard, undofile on
- `smartcase` + `ignorecase`, `splitright`, `splitbelow`, `termguicolors`
- `updatetime=250`, `timeoutlen=300`
- Default indent 4 spaces (overridden per-project by `vim-sleuth`)

---

## Keybindings cheatsheet

Leader = `<Space>`. Modes: **n** normal, **i** insert, **v** visual.

### LSP (active when a server attaches)

| Key            | Mode | Action                          |
| -------------- | ---- | ------------------------------- |
| `gd`           | n    | Go to definition                |
| `gr`           | n    | List references                 |
| `gi`           | n    | Go to implementation            |
| `K`            | n    | Hover docs                      |
| `<leader>ca`   | n    | Code action                     |
| `<leader>rn`   | n    | Rename symbol                   |
| `[d` / `]d`    | n    | Prev / next diagnostic          |
| `<leader>ih`   | n    | Toggle inlay hints              |
| `<leader>lf`   | n,v  | Format buffer (conform)         |

### Telescope / find

| Key                  | Action                          |
| -------------------- | ------------------------------- |
| `<C-p>`              | Find files                      |
| `<leader>fg`         | Live grep                       |
| `<leader><leader>`   | Recent files                    |
| `<leader>fh`         | Help tags                       |
| `<leader>fb`         | File browser (telescope ext)    |
| `<leader>fn`         | Browse current buffer's dir     |

### File trees

| Key            | Action                                 |
| -------------- | -------------------------------------- |
| `<C-n>`        | Toggle Neo-tree (left sidebar)         |
| `<leader>bf`   | Neo-tree as floating window            |
| `-`            | Open Oil file browser (floating)       |

### Git

| Key            | Action                  |
| -------------- | ----------------------- |
| `<leader>gp`   | Gitsigns: preview hunk  |
| `<leader>gb`   | Gitsigns: blame line    |
| `:G`, `:Gdiffsplit`, … | Fugitive porcelain |

### Tests (vim-test + vimux)

Tests run via vimux in a tmux pane next to nvim (must be inside a tmux session).


| Key            | Action         |
| -------------- | -------------- |
| `<leader>tn`   | Test nearest   |
| `<leader>tf`   | Test file      |
| `<leader>ts`   | Test suite     |
| `<leader>tl`   | Test last      |
| `<leader>tv`   | Test visit     |

### Debug (nvim-dap)

| Key             | Action                                  |
| --------------- | --------------------------------------- |
| `<leader>db`    | Toggle breakpoint                       |
| `<leader>dc`    | Continue / start                        |
| `<leader>dus`   | Toggle DAP UI (scopes sidebar)          |
| `<leader>dgt`   | Go: debug nearest test                  |
| `<leader>dgl`   | Go: debug last test                     |

### Go (gopher.nvim struct tags)

| Key             | Action                       |
| --------------- | ---------------------------- |
| `<leader>gsj`   | Add JSON struct tags         |
| `<leader>gsy`   | Add YAML struct tags         |

Additional Go commands available as `:Go*` from `ray-x/go.nvim` (e.g. `:GoFillStruct`, `:GoImpl`, `:GoAddTest`).

### Completion (nvim-cmp, insert mode)

| Key           | Action                                     |
| ------------- | ------------------------------------------ |
| `<C-Space>`   | Trigger completion                         |
| `<C-j>`/`<C-k>` | Next / previous item                     |
| `<C-b>`/`<C-f>` | Scroll docs                              |
| `<Tab>`/`<S-Tab>` | Next/prev item or snippet jump         |
| `<CR>`        | Confirm selection (no auto-select)         |
| `<C-e>`       | Abort                                      |

### Window navigation (vim-tmux-navigator)

| Key       | Action                                  |
| --------- | --------------------------------------- |
| `<C-h/j/k/l>` | Move between nvim splits and tmux panes |

### Comment.nvim

| Key       | Mode | Action                       |
| --------- | ---- | ---------------------------- |
| `gcc`     | n    | Toggle comment on line       |
| `gc`      | v    | Toggle comment on selection  |

[lazy.nvim]: https://github.com/folke/lazy.nvim
