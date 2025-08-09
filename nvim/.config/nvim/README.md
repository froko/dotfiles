# NeoVim

[NeoVim](https://neovim.io/) is my preferred text editor.

## Plugins

The configuration includes, the following plugins, which are managed using
[lazy.nvim](https://github.com/folke/lazy.nvim):

### Core Plugins

- [catppuccin/nvim](https://github.com/catppuccin/nvim): A color scheme for
  NeoVim that provides a pleasant and consistent look.
- [folke/flash.nvim](https://github.com/folke/flash.nvim): A plugin that
  provides a flash-like experience for navigating and searching in NeoVim.
- [ibhagwan/fzf-lua](https://github.com/ibhagwan/fzf-lua): A Lua-based
  implementation of FZF (Fuzzy Finder) for NeoVim, providing fast and efficient
  searching capabilities.
- [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim): A
  fast and lightweight status line for NeoVim that provides useful information
  about the current file and mode.
- [stevearc/oil.nvim](https://github.com/stevearc/oil.nvim): A plugin that
  provides a file explorer for NeoVim, allowing you to navigate and manage files
  easily. A powerful fuzzy finder for NeoVim that allows you to search through
  files, directories, command history and much more.
- [christoomey/vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator):
  A plugin that allows you to navigate between Vim and Tmux panes seamlessly.
- [folke/which-key.nvim](https://github.com/folke/which-key.nvim): A plugin that
  provides a popup menu for displaying available keybindings in NeoVim.

### Coding Plugins

- [Saghen/blink.cmp](https://github.com/saghen/blink.cmp): A plugin that
  provides a fast and efficient autocompletion experience for NeoVim, allowing
  you to quickly complete code snippets and symbols.
- [stevearc/conform.nvim](https://github.com/stevearc/conform.nvim): A plugin
  that provides code formatting and linting capabilities for NeoVim, allowing
  you to conform your code to a specific style.
- [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs): A plugin
  that automatically inserts matching pairs of brackets, quotes, and other
  characters in NeoVim, making coding more efficient.
- [tpope/vim-commentary](https://github.com/tpope/vim-commentary): A plugin that
  provides easy commenting and uncommenting of code in NeoVim, allowing you to
  quickly toggle comments on and off.
- [mfussenegger/nvim-lint](https://github.com/mfussenegger/nvim-lint): A plugin
  that provides linting capabilities for NeoVim, allowing you to check your code
  for errors and warnings.
- [MeanderingProgrammer/render-markdown.nvim](https://github.com/MeanderingProgrammer/render-markdown.nvim):
  A plugin that provides a live preview of Markdown files in NeoVim, allowing
  you to see the rendered output as you edit.
- [williamboman/mason.nvim](https://github.com/mason-org/mason.nvim): A plugin
  that provides a package manager for NeoVim, allowing you to easily install and
  manage external tools and language servers.
- [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter):
  A plugin that provides syntax highlighting and code parsing for NeoVim using
  Tree-sitter.

I use the built-in LSP client of NeoVim with the built-in autocompletion. Read
more about the LSP client in the
[NeoVim documentation](https://neovim.io/doc/user/lsp.html).

Check out this
[GitHub repository](https://github.com/neovim/nvim-lspconfig/tree/master/lsp)
with LSP configurations for various languages.

### Custom Plugins

There is a folder named `lua/plugins/custom` that is reserved for custom plugins
you may add to your NeoVim configuration. This folder is excluded from the Git
repository, so you can add your own plugins without affecting the shared
configuration.

## Keybindings

The configuration also includes the following keybindings, while the `<Leader>`
key is set to `Space`:

- Standard bindings:
  - `jk`: Exit insert mode in Vim (alternative to `Esc`).
  - `<Leader>r`: Reload the current buffer.

- Buffers
  - `bj`: Go to the previous buffer.
  - `bk`: Go to the next buffer.
  - `<Leader>bb`: Close the current buffer.
  - `<Leader>ba`: Close all buffers except the current one.
  - `<Leader>bA`: Close all buffers.
  - `<Space><Space>`: Select a buffer using fzf-lua.

- Windows
  - `<Leader>ws`: Split the current window vertically.
  - `<Leader>wh`: Split the current window horizontally.
  - `<Leader>ww`: Close the current window.

- blink.cmp
  - `<C-Space>`: Trigger autocompletion.
  - `<C-n>`: Select the next item in the autocompletion popup.
  - `<C-p>`: Select the previous item in the autocompletion popup.
  - `<C-y>`: Confirm the selected item in the autocompletion popup.

- fzf-lua
  - `<Leader>fa`: Find All Files.
  - `<Leader>fc`: Find Commands.
  - `<Leader>fd`: Find Diagnostics in Document.
  - `<Leader>fD`: Find Diagnostics in Workspace.
  - `<Leader>ff`: Find Git Files.
  - `<Leader>fg`: Find with Grep.
  - `<Leader>fh`: Find Help.
  - `<Leader>fk`: Find Keymaps.
  - `<Leader>fs`: Find Symbols in Document.
  - `<Leader>fS`: Find Symbols in Workspace.
  - `<Space><Space>`: Find Buffers.
  - `<C-q>`: Send the selection to Quickfix List.

- flash.nvim
  - `s`: Jump to a character sequence in the current buffer.

- nvim-treesitter
  - `<CR>`: Initialize Selection.
  - `<CR>`: Increase Selection.
  - `<BS>`: Decrease Selection.

- oil.nvim
  - `-`: Open the Oil file explorer or move up one directory.
  - `g.`: Toggle the visibility of hidden files in Oil.
  - `<C-c>`: Close the Oil file explorer.
  - `<C-h>`: Open the selected file in a horizontal split.
  - `<C-s>`: Open the selected file in a vertical split.

- Built-in LSP
  - `K`: Show documentation for the symbol under the cursor.
  - `gd`: Go to the definition of the symbol under the cursor.
  - `gra`: Show code actions available at the cursor position.
  - `gri`: Go to the implementation of the symbol under the cursor.
  - `grn`: Rename the symbol under the cursor.
  - `grr`: Show references to the symbol under the cursor.
  - `grt`: Show type definition of the symbol under the cursor.

  - `<C-n>`: Select the next item in the autocompletion popup.
  - `<C-p>`: Select the previous item in the autocompletion popup.
  - `<C-y>`: Confirm the selected item in the autocompletion popup.
