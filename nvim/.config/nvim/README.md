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
- [nvim-lualine/lualine.nvim](https://github.com/nvim-lualine/lualine.nvim): A
  fast and lightweight status line for NeoVim that provides useful information
  about the current file and mode.
- [folke/noice.nvim](https://github.com/folke/noice.nvim): A plugin that
  provides a better user interface for NeoVim, including notifications, command
  history, and more.
- [stevearc/oil.nvim](https://github.com/stevearc/oil.nvim): A plugin that
  provides a file explorer for NeoVim, allowing you to navigate and manage files
  easily.
- [nvim-telescope/telescope.nvim](https://github.com/nvim-telescope/telescope.nvim):
  A powerful fuzzy finder for NeoVim that allows you to search through files,
  directories, command history and much more.
- [christoomey/vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator):
  A plugin that allows you to navigate between Vim and Tmux panes seamlessly.
- [folke/which-key.nvim](https://github.com/folke/which-key.nvim): A plugin that
  provides a popup menu for displaying available keybindings in NeoVim.

### Coding Plugins

- [stevearc/conform.nvim](https://github.com/stevearc/conform.nvim): A plugin
  that provides code formatting and linting capabilities for NeoVim, allowing
  you to conform your code to a specific style.
- [windwp/nvim-autopairs](https://github.com/windwp/nvim-autopairs): A plugin
  that automatically inserts matching pairs of brackets, quotes, and other
  characters in NeoVim, making coding more efficient.
- [tpope/vim-commentary](https://github.com/tpope/vim-commentary): A plugin that
  provides easy commenting and uncommenting of code in NeoVim, allowing you to
  quickly toggle comments on and off.
- [nvim-treesitter/nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter):
  A plugin that provides syntax highlighting and code parsing for NeoVim using
  Tree-sitter.
- [nvim-ts-autotag](https://github.com/windwp/nvim-ts-autotag): A plugin that
  automatically closes and renames HTML and XML tags in NeoVim, making it easier
  to work with markup languages.

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
  - `<Leader>e`: Reload the current buffer.

- Buffers
  - `bj`: Go to the previous buffer.
  - `bk`: Go to the next buffer.
  - `<Leader>bb`: Close the current buffer.
  - `<Leader>ba`: Close all buffers except the current one.
  - `<Leader>bA`: Close all buffers.
  - `<Space><Space>`: Select a buffer using Telescope.

- Windows
  - `<Leader>ws`: Split the current window vertically.
  - `<Leader>wh`: Split the current window horizontally.
  - `<Leader>ww`: Close the current window.

- flash.nvim
  - `s`: Jump to a character sequence in the current buffer.
  - `S`: Select a region using Treesitter.

- noice.nvim
  - `<Leader>fn`: Show the last notifications.
  - `<Leader>nc`: Clear all notifications.
  - `<Leader>nn`: Hide the notification window.

- oil.nvim
  - `-`: Open the Oil file explorer or move up one directory.
  - `g.`: Toggle the visibility of hidden files in Oil.
  - `<C-c>`: Close the Oil file explorer.
  - `<C-s>`: Open the selected file in a horizontal split.
  - `<C-v>`: Open the selected file in a vertical split.

- telescope.nvim
  - `<Leader>ff`: Find Files.
  - `<Leader>fg`: Find by Grep.
  - `<Leader>fh`: Find Help.
  - `<Leader>fk`: Find Keymaps.
  - `<Leader>fr`: Find Recent Files.
  - `<Leader>fs`: Find Symbols.
  - `<Leader>fS`: Find Symbols in Workspace.
  - `<Leader>fd`: Find Diagnostics.
  - `<Leader>fn`: Find Notifications.
  - `<Leader>f.`: Find NeoVim Config Files.

- nvim-treesitter
  - `<CR>`: Initialize Selection.
  - `<CR>`: Increase Selection.
  - `<BS>`: Decrease Selection.

- Built-in LSP
  - `K`: Show documentation for the symbol under the cursor.
  - `gra`: Show code actions available at the cursor position.
  - `gri`: Go to the implementation of the symbol under the cursor.
  - `grn`: Rename the symbol under the cursor.
  - `grr`: Show references to the symbol under the cursor.
  - `grt`: Show type definition of the symbol under the cursor.
  - `gd`: Go to the definition of the symbol under the cursor.
  - `gD`: Go to the declaration of the symbol under the cursor.

  - `<C-p>`: Toggle autocompletion popup in Insert mode.
  - `<C-n>`: Select the next item in the autocompletion popup.
  - `<C-p>`: Select the previous item in the autocompletion popup.
  - `<C-y>`: Confirm the selected item in the autocompletion popup.
