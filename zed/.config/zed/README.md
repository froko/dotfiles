# Zed

[Zed](https://zed.dev) is my preferred text editor.

## Configuration

The configuration cleans up the UI and uses catppuccin Macchiato as colorscheme.
And - most importantly - it sets the vim mode :-)

## Keybindings

The keybindings try to replicate my Neovim setup as closely as possible.

- Standard bindings:
  - `jk`: Exit insert mode in Vim (alternative to `Esc`).
  - `space ff`: Toggle the file finder for quick navigation

- Panes
  - `ctrl-h`: Go to left pane
  - `ctrl-j`: Go to lower pane
  - `ctrl-k`: Go to uppper pane
  - `ctrl-l`: Go to right pane

- Docks
  - `space e`: Toggle left dock (usually the file navigator)
  - `space a`: Toggle right dock (AI)

- Buffers
  - `bj`: Go to the previous buffer.
  - `bk`: Go to the next buffer.
  - `space bb`: Close the current buffer.
  - `space ba`: Close all buffers.
  - `space bA`: Close all buffers except the current one.
  - `space space`: Select an open buffer.

- Windows
  - `space ws`: Split and move the current buffer to the right.
  - `space wh`: Split and move the current buffer down.
  - `space ww`: Close the current window.
