# tmux

[tmux](https://github.com/tmux/tmux/wiki) is my terminal multiplexer of choice.

## Plugins

- [tmux-plugins/tpm](https://github.com/tmux-plugins/tpm): The plugin manager
  for tmux, which allows you to easily install and manage plugins.
- [catppuccin/tmux](https://github.com/catppuccin/tmux): A color scheme for tmux
  that provides a pleasant and consistent look.
- [christoomey/vim-tmux-navigator](https://github.com/christoomey/vim-tmux-navigator):
  A plugin that allows you to navigate between Vim and Tmux panes seamlessly.
- [tmux-plugins/tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect):
  A plugin that allows you to save and restore tmux sessions, including window
  layouts and pane contents.
- [tmux-plugins/tmux-continuum](https://github.com/tmux-plugins/tmux-continuum):
  A plugin that automatically saves and restores tmux sessions, ensuring that
  your work is never lost.

## Keybindings

The configuration includes the following keybindings, while `<C-a>` is the
default prefix key:

- `r`: Reload the tmux configuration file.
- `|`: Split the current pane vertically.
- `-`: Split the current pane horizontally.
- `j`: Resize the current pane down.
- `k`: Resize the current pane up.
- `h`: Resize the current pane left.
- `l`: Resize the current pane right.
- `c`: Create a new window.
- `m`: Toggle the current pane's zoom state.
- `E`: Display a popup with the yazi file explorer.
- `G`: Display a popup with lazygit.
- `P`: Display a popup with a new shell.
- `T`: Open another tmux session using fzf.
- `I`: Install plugins.
- `U`: Update plugins.
- `,`: Rename the current pane.
