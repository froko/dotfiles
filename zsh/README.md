# zsh

I use [zsh](https://www.zsh.org/) as my shell. The configuration defines the
following aliases:

- `reload`: Reload the `.zshrc` file.
- `c`: Clear the terminal screen.
- `t`: Start a new tmux session using `sesh connect`.
- `e`: Alias for `yazi`, my preferred file manager.
- `v`: Alias for `nvim`, my preferred text editor.
- `lg`: Alias for `lazygit`, my preferred git client for the terminal.
- `dot`: Navigate to the dotfiles directory and open it in `nvim`.
- `lpath`: Show the current PATH variable.

- `l`: Alias for `eza`, a modern replacement for the `ls` command.
- `ll`: Alias for `eza`, a modern replacement for the `ls` command showing also
  hidden files.

- `cd`: Alias for `zoxide`, a smarter `cd` command that remembers your directory
  history and allows you to jump to directories quickly.
- `cdi`: Find and jump to a directory using `zoxide` with interactive selection
  using `fzf`.
- `..`: Navigate to the parent directory.
- `...`: Navigate to the grandparent directory.
- `....`: Navigate to the great-grandparent directory.

Use `ctrl+r` to search through the command history using `fzf`.

The configuration also includes the following plugins:

- [pure](https://github.com/sindresorhus/pure): A minimal, fast, and beautiful
  ZSH prompt that shows the current directory, git status, and more.
- [eza](https://github.com/eza-community/eza): A modern replacement for the `ls`
  command
- [fzf](https://github.com/junegunn/fzf): A command-line fuzzy finder that
  allows you to search through files, directories, and command history. It is
  used in the zsh configuration to enhance the command line experience.
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions):
  Provides interactive suggestions based on command history and completions.
- [zoxide](https://github.com/ajeetdsouza/zoxide): A smarter cd command that
  remembers your directory history and allows you to jump to directories
  quickly.

The configuration in this dotfiles repository only includes the `.zshrc` file.
If you you have special environment variables or other settings, you can use
either the `.zshenv` or `.zprofile` files in your home directory to set them up.
Doing it like this allows you to keep your `.zshrc` in its default state and you
are able to update it without losing your custom settings.

In my case, I've included the following environment variables in my `.zprofile`
file:

```zsh
if [[ -f /opt/homebrew/bin/brew ]]; then
    # Homebrew exists at /opt/homebrew for arm64 macos
    eval $(/opt/homebrew/bin/brew shellenv)
elif [[ -f /usr/local/bin/brew ]]; then
    # or at /usr/local for intel macos
    eval $(/usr/local/bin/brew shellenv)
elif [[ -d /home/linuxbrew/.linuxbrew ]]; then
    # or from linuxbrew
    test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
    test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
```
