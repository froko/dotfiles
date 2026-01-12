# vim

Vim acts as a fallback editor on systems where NeoVim is not available.

## Plugins

The configuration includes the following plugins, which are managed using
[vim-plug](https://github.com/junegunn/vim-plug):

- [catppuccin/vim](https://github.com/catppuccin/vim): A color scheme for Vim
  that provides a pleasant and consistent look.
- [vim-airline/vim-airline](https://github.com/vim-airline/vim-airline): A
  lightweight status line for Vim that provides useful information about the
  current file and mode.
- [tribela/vim-transparent](https://github.com/tribela/vim-transparent): A
  plugin that allows you to set a transparent background for Vim, making it
  blend with your terminal background.
- [christoomey/vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator):
  A plugin that allows you to navigate between Vim and Tmux panes seamlessly.
- [tpope/vim-surround](https://github.com/tpope/vim-surround): A plugin that
  provides easy manipulation of surrounding characters, such as quotes,
  parentheses, and tags.
- [easymotion/vim-easymotion](https://github.com/easymotion/vim-easymotion): A
  plugin that allows you to quickly jump to any location in the current file
  using a minimal number of keystrokes.

Plugins can be installed by running the following command in Vim:

```vim
:PlugInstall
```

Update plugins by running:

```vim
:PlugUpdate
```

## Keybindings

The configuration also includes the following keybindings, while the `<Leader>`
key is set to `Space`:

- Standard bindings:
  - `jk`: Exit insert mode in Vim (alternative to `Esc`).
  - `<Leader>e`: Toggle the `netrw` file explorer in Vim.
- Buffers
  - `bj`: Go to the previous buffer.
  - `bk`: Go to the next buffer.
  - `<Leader>bb`: Close the current buffer.
  - `<Leader>ba`: Close all buffers except the current one.
  - `<Leader>bA`: Close all buffers.
  - `<Space><Space>`: Toggle the buffer list.
- easy-motion
  - `s`: Search for 2-character sequences in the current buffer.
