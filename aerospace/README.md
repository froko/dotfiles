# AeroSpace

[AeroSpace](https://nikitabobko.github.io/AeroSpace/) is my tiling window
manager for MacOS. It starts at login and arranges windows into tiles instead of
free-floating windows.

## Workspaces

Windows are automatically assigned to a named workspace by application, so each
app always comes up in the same place:

| Workspace | Purpose  | Auto-assigned application    |
| --------- | -------- | ---------------------------- |
| `A`       | General  | Google Chrome, Brave Browser |
| `G`       | Git      | GitKraken                    |
| `S`       | Slack    | Slack                        |
| `T`       | Terminal | WezTerm                      |
| `W`       | Work     | Zed                          |

## Keybindings

The `alt` key acts as the modifier throughout.

### Focus and move

| Key                   | Description                    |
| --------------------- | ------------------------------ |
| `alt-h/j/k/l`         | Focus left/down/up/right       |
| `alt-shift-h/j/k/l`   | Move window left/down/up/right |
| `alt-a/g/s/t/w`       | Switch to workspace A/G/S/T/W  |
| `alt-shift-a/g/s/t/w` | Move window to that workspace  |
| `alt-tab`             | Switch to previous workspace   |

### Layout

| Key         | Description                          |
| ----------- | ------------------------------------ |
| `alt-slash` | Toggle horizontal/vertical tiles     |
| `alt-comma` | Toggle horizontal/vertical accordion |
| `alt-f`     | Toggle fullscreen                    |

### Modes

| Key             | Description          |
| --------------- | -------------------- |
| `alt-r`         | Enter _resize_ mode  |
| `alt-semicolon` | Enter _service_ mode |

In **resize** mode: `h`/`l` shrink/grow width, `j`/`k` grow/shrink height,
`minus`/`equal` resize smartly, `b` balances sizes. `enter` or `esc` returns to
main mode.

In **service** mode: `esc` reloads the config, `r` resets the layout, `f`
toggles floating/tiling, `backspace` closes all windows but the current one, and
`h/j/k/l` join the current window with its neighbour. Each returns to main mode.

### Session scripts

| Key           | Description                                       |
| ------------- | ------------------------------------------------- |
| `alt-shift-i` | Launch the workspace apps (`workspace-init.sh`)   |
| `alt-shift-q` | Quit the workspace apps (`workspace-shutdown.sh`) |

Both scripts live in [`bin`](../bin/README.md) and must be stowed for these
bindings to work.
