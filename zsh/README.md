# zsh

I use [zsh](https://www.zsh.org/) as my shell. Vi mode is enabled, and `nvim` is
set as the default editor.

## Aliases

General:

- `reload`: Reload the `.zshrc` file.
- `c`: Clear the terminal screen.
- `t`: Start a new tmux session using `sesh connect`.
- `v`: Alias for `nvim`, my preferred text editor.
- `lg`: Alias for `lazygit`, my preferred git client for the terminal.
- `dot`: Navigate to the dotfiles directory and open it in `nvim`.
- `lpath`: Show the current PATH variable.

Notes:

- `notes`: Navigate to the notes directory and pick a note to edit with `zk`.
- `daily`: Create or open today's journal note using `zk daily`.

Listing files:

- `l`: Alias for `eza`, a modern replacement for the `ls` command.
- `ll`: Alias for `eza`, a modern replacement for the `ls` command showing also
  hidden files.
- `tree`: Show the directory tree three levels deep, honouring `.gitignore`.

Navigation:

- `cd`: Alias for `zoxide`, a smarter `cd` command that remembers your directory
  history and allows you to jump to directories quickly.
- `..`: Navigate to the parent directory.
- `...`: Navigate to the grandparent directory.
- `....`: Navigate to the great-grandparent directory.

Git:

- `gs`: Short `git status` with the branch header, ahead/behind counts and the
  number of stash entries.
- `gfa`: Fetch from all remotes including tags, pruning remote-tracking refs for
  branches that no longer exist upstream.
- `glog`: Git log as a decorated, colored commit graph with one line per commit.

## Functions

- `e`: A `yazi` wrapper that `cd`s into the last visited directory on exit.
- `ff`: Fuzzy find files using `fzf` with a `bat` preview. Press `enter` to open
  the selected file in `nvim`.
- `fg`: Live grep using `rg` and `fzf` with a `bat` preview. Press `enter` to
  open the file at the matching line in `nvim`.
- `gco`: Check out a branch selected with `fzf` from all local and remote
  branches, sorted by most recent commit.
- `gdiff`: Pick a commit from the log with `fzf`, previewing its stat, and
  review it hunk by hunk using `hunk`.
- `just`: Runs the local `justfile` when one is present, otherwise falls back to
  the [global justfile](../just/.config/just/README.md).

Use `ctrl+r` to search through the command history using `fzf`.

## Plugins and tools

- [pure](https://github.com/sindresorhus/pure): A minimal, fast, and beautiful
  ZSH prompt that shows the current directory, git status, and more.
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions):
  Provides interactive suggestions based on command history and completions.
- [fzf](https://github.com/junegunn/fzf): A command-line fuzzy finder that
  allows you to search through files, directories, and command history. It is
  used in the zsh configuration to enhance the command line experience.
- [zoxide](https://github.com/ajeetdsouza/zoxide): A smarter cd command that
  remembers your directory history and allows you to jump to directories
  quickly.
- [eza](https://github.com/eza-community/eza): A modern replacement for the `ls`
  command, used by the listing aliases above.
- [fd](https://github.com/sharkdp/fd) and
  [ripgrep](https://github.com/BurntSushi/ripgrep): Back the `fzf` file and text
  searches.

## Portability

The `.zshrc` in this repository is intended to be byte-identical on every
machine, whether it is macOS with Homebrew, Debian/Ubuntu or Arch. It contains
no `brew` calls and no checks against `$OSTYPE`.

Package managers install zsh plugins to different locations, so instead of
branching on the operating system, the configuration probes a list of candidate
paths and uses the first one that exists. Adding support for another
distribution means appending a path to a list, not adding a new code branch.

For `zsh-autosuggestions` the candidates are, in order:

1. `$HOMEBREW_PREFIX/share/zsh-autosuggestions/` (macOS and Linuxbrew)
2. `/usr/share/zsh/plugins/zsh-autosuggestions/` (Arch)
3. `/usr/share/zsh-autosuggestions/` (Debian/Ubuntu)
4. `$HOME/.zsh/zsh-autosuggestions/` (manual clone, see
   [INSTALL.md](../INSTALL.md))

For the `pure` prompt, every candidate directory that exists is appended to
`fpath`, and `promptinit` picks up `prompt_pure_setup` from whichever one
provides it:

1. `$HOMEBREW_PREFIX/share/zsh/site-functions`
2. `/usr/share/zsh/site-functions`
3. `/usr/share/zsh/vendor-functions`
4. `/usr/share/zsh-theme-pure`
5. `$HOME/.zsh/pure` (manual clone)

If `pure` is not found, the prompt falls back to a plain `%~ %#` rather than
erroring. Likewise `fzf` and `zoxide` are only initialised when they are
actually on `PATH`, so a partial installation does not print errors on every new
shell.

> [!NOTE] The Linux candidate paths reflect where these packages are expected to
> land, but — like the Linux sections of [INSTALL.md](../INSTALL.md) — they have
> not been verified on a live system. The macOS path is the one in active use.
> If a plugin is not picked up on your distribution, find the file with
> `dpkg -L`/`pacman -Ql` and add its directory to the corresponding list.

## Machine-specific settings

The configuration in this dotfiles repository only includes the `.zshrc` file.
If you have special environment variables or other settings, you can use either
the `.zshenv` or `.zprofile` files in your home directory to set them up. Doing
it like this allows you to keep your `.zshrc` in its default state and you are
able to update it without losing your custom settings.

This is also where anything genuinely machine-specific belongs. In particular,
`brew shellenv` exports `HOMEBREW_PREFIX`, which the `.zshrc` then picks up
without ever having to call `brew` itself.

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
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"  # nvm from Homebrew
[ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# pnpm stores its global binaries under Library on macOS and under
# ~/.local/share on Linux.
if [[ "$OSTYPE" == darwin* ]]; then
  export PNPM_HOME="$HOME/Library/pnpm"
else
  export PNPM_HOME="$HOME/.local/share/pnpm"
fi
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
```

Note that `$OSTYPE` is fine to use _here_ — this file is per-machine and not
tracked in the repository. The point of the design is to keep that kind of
branching out of the shared `.zshrc`.
