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
- `|`: Split the current pane horizontally (panes side by side).
- `-`: Split the current pane vertically (panes stacked).
- `j`: Resize the current pane down.
- `k`: Resize the current pane up.
- `h`: Resize the current pane left.
- `l`: Resize the current pane right.
- `c`: Create a new window.
- `m`: Toggle the current pane's zoom state.
- `x`: Kill the current pane (without a confirmation prompt).
- `E`: Display a popup with yazi (file manager).
- `G`: Display a popup with lazygit.
- `T`: Open another tmux session using fzf.
- `I`: Install plugins.
- `U`: Update plugins.
- `,`: Rename the current window.

Navigation between panes is handled by `vim-tmux-navigator`, so `<C-h>`,
`<C-j>`, `<C-k>` and `<C-l>` move between tmux panes and Neovim splits alike —
no prefix needed.

In copy mode, vi keys are used: `v` starts the selection and `y` copies it.

## Appearance

The Catppuccin **Macchiato** flavour is set via `@catppuccin_flavor`. All colors
in `tmux.conf` reference the theme's `@thm_*` variables rather than hard-coded
hex values, so changing the flavour restyles everything consistently.

> **Note:** Catppuccin defines its palette with `set -ogq`, which does not
> overwrite values that are already set. Reloading the config with `<C-a> r` is
> therefore _not_ enough to switch flavours — run `tmux kill-server` (or unset
> the `@thm_*` variables) so the new palette loads.

### Pane focus indicator

The active pane is marked in three complementary ways, because a shared border
line alone is ambiguous — it cannot show which of the two adjacent panes it
belongs to:

- A per-pane title line (`pane-border-status bottom`) showing the pane index and
  running command, highlighted in lavender for the active pane.
- A heavy border (`pane-border-lines heavy`) in lavender, so focus is signalled
  by weight as well as colour.
- Arrow indicators (`pane-border-indicators arrows`) pointing into the active
  pane.

The title line sits at the _bottom_ because `status-position` is `top`; placing
it on top would leave it flush against the status bar with no visual separation.

Inactive panes are deliberately _not_ dimmed via `window-style`: setting a
concrete background colour makes tmux emit an opaque background, which destroys
terminal transparency.
