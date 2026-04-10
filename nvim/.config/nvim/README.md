# Neovim

[Neovim](https://neovim.io/) (0.12+) is my preferred text editor.

## Architecture

The configuration is structured as a minimal base that can be extended per
machine using optional plugin templates:

- `lua/` — Core configuration (options, keymaps, autocmds, essentials, coding)
- `lsp/` — Native LSP server configurations loaded by `vim.lsp.config()`
- `queries/` — Treesitter query files (highlights, folds, indents, injections)
- `templates/` — Optional plugin configurations (git-tracked)
- `plugin/` — Active plugin configurations as symlinks into `templates/` (git-ignored)

## Plugin Management

Plugins are managed using the built-in `vim.pack` package manager. Optional
templates can be activated via symlinks:

```sh
./templates/manage.sh list              # show all templates and their status
./templates/manage.sh enable web react  # enable templates
./templates/manage.sh disable react     # disable templates
```

## Treesitter Queries

Treesitter query files are maintained locally in the `queries/` directory.
They can be synchronized with the upstream `nvim-treesitter` repository:

```sh
./queries/sync.sh              # sync all languages
./queries/sync.sh --diff       # preview changes without writing
./queries/sync.sh lua yaml     # sync specific languages
```

## Plugins

### Core

- [catppuccin/nvim](https://github.com/catppuccin/nvim): Color scheme.
- [christoomey/vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator):
  Seamless navigation between Vim and Tmux panes.
- [folke/which-key.nvim](https://github.com/folke/which-key.nvim): Popup menu
  for displaying available keybindings.
- [ibhagwan/fzf-lua](https://github.com/ibhagwan/fzf-lua): Fuzzy finder for
  files, text, diagnostics, symbols, and more.
- [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim):
  Lightweight status line.
- [nvim-tree/nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons):
  File type icons.
- [stevearc/oil.nvim](https://github.com/stevearc/oil.nvim): File explorer that
  lets you edit the filesystem like a buffer.

### Coding

- [mason-org/mason.nvim](https://github.com/mason-org/mason.nvim): Package
  manager for LSP servers, formatters, and linters.
- [stevearc/conform.nvim](https://github.com/stevearc/conform.nvim): Format on
  save with LSP fallback.
- [mfussenegger/nvim-lint](https://github.com/mfussenegger/nvim-lint):
  Asynchronous linting.
- [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs): Automatic
  bracket and quote pairing.
- [MeanderingProgrammer/render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim):
  Rendered Markdown inside the editor.
- [iamcco/markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim):
  Live Markdown preview in the browser.

LSP, diagnostics, and treesitter highlighting are configured using Neovim's
built-in APIs (`vim.lsp.config`, `vim.lsp.enable`, `vim.diagnostic.config`,
`vim.treesitter.start`).

### Templates (optional)

| Template | Description |
|----------|-------------|
| `angular` | Angular language server |
| `astro` | Astro language server, prettier, eslint |
| `blink` | [blink.cmp](https://github.com/saghen/blink.cmp) autocompletion |
| `copilot` | [GitHub Copilot](https://github.com/github/copilot.vim) |
| `flash` | [flash.nvim](https://github.com/folke/flash.nvim) jump navigation |
| `git` | [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim), [neogit](https://github.com/neogitorg/neogit), [diffview.nvim](https://github.com/sindrets/diffview.nvim) |
| `kulala` | [kulala.nvim](https://github.com/mistweaverco/kulala.nvim) HTTP client |
| `react` | JSX/TSX treesitter, prettier, eslint |
| `svelte` | Svelte language server, prettier, eslint |
| `vimtest` | [vim-test](https://github.com/vim-test/vim-test) with jest/playwright |
| `vue` | Vue language server with hybrid mode, prettier, eslint |
| `web` | Base web development: vtsls, eslint, tailwindcss, prettier |
| `zk` | [zk-nvim](https://github.com/zk-org/zk-nvim) note-taking |

## Keybindings

The `<Leader>` key is set to `Space`.

### General

| Key | Description |
|-----|-------------|
| `jk` | Exit insert mode |
| `<Esc>` | Clear search highlight |
| `<Leader>r` | Reload current buffer |
| `<Leader>s` | Search and replace in file |
| `<Leader>as` | Toggle spell checking |
| `<Leader>ad` | Toggle diagnostics |
| `<C-d>` / `<C-u>` | Scroll down/up (centered) |

### Buffers

| Key | Description |
|-----|-------------|
| `<Space><Space>` | Find buffers (fzf-lua) |
| `<Leader>bb` | Close current buffer |
| `<Leader>ba` | Close all buffers |
| `<Leader>bA` | Close all buffers except current |

### Fuzzy Finder (fzf-lua)

| Key | Description |
|-----|-------------|
| `<Leader>ff` | Find files |
| `<Leader>fg` | Find text in document |
| `<Leader>fG` | Find text in workspace |
| `<Leader>fd` | Find diagnostics in document |
| `<Leader>fD` | Find diagnostics in workspace |
| `<Leader>fs` | Find symbols in document |
| `<Leader>fS` | Find symbols in workspace |
| `<Leader>fh` | Find help |
| `<C-q>` | Send selection to quickfix list |

### File Explorer (oil.nvim)

| Key | Description |
|-----|-------------|
| `-` | Open file explorer / navigate up |
| `g.` | Toggle hidden files |
| `g?` | Show help |
| `<CR>` | Open file |
| `<C-s>` | Open in horizontal split |
| `<C-v>` | Open in vertical split |
| `<C-c>` | Close explorer |

### LSP (built-in defaults + overrides)

| Key | Description |
|-----|-------------|
| `gd` | Go to definition |
| `grr` | Show references (fzf-lua) |
| `gra` | Code actions (built-in) |
| `gri` | Go to implementation (built-in) |
| `grn` | Rename symbol (built-in) |
| `grt` | Go to type definition (built-in) |
| `K` | Hover documentation (built-in) |

### Move Block (visual mode)

| Key | Description |
|-----|-------------|
| `<Down>` | Move selection down |
| `<Up>` | Move selection up |
