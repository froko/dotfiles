# Just

[Just](https://github.com/casey/just) is my preferred automation tool and task
executor.

The `just` wrapper function in [`.zshrc`](../../../zsh/README.md) runs a local
`justfile` when the current directory has one, and otherwise falls back to the
global justfile documented below.

## Global justfile preset

- `just upgrade`: Updates your dependencies:
  - homebrew applications
  - neovim plugins (`vim.pack.update`)
  - global npm dependencies
- `just restore`: Restores your tmux sessions using `tmux-resurrect`
- `just sync`: Synchronizes your `zk` notes
- `just note [text]`: Appends a timestamped entry to `$NOTES/JOURNAL.md`,
  creating today's date heading if missing. Prompts for the text when called
  without arguments.
- `just clean`: Performs a quick clean-up of your MacOS system by deleting
  caches, logs, the trash bin and temp files

Recipes run their command quietly and only print output when something fails.
