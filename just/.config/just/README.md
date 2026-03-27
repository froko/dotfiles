# Just

[Just](https://github.com/casey/just) is my preferred automation tool and task
executor.

## Global justfile preset

- `just upgrade`: Updates your dependendies:
  - homebrew applications
  - neovim plugins
  - mason-controlled language servers
  - tmux plugins
  - global npm dependencies
- `just restore`: Restores your tmux sessions using `tmux-resurrect`
- `just sync`: Synchronizes your `zk` notes and `taskwarrior` tasks
- `just clean`: Performs a quick clean-up of your MacOS system by deleting
  cached, logs, the trash bin and temp files
