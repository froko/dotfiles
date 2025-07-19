# My dot files

## Installation

Clone the repository to your home directory:

```bash
git clone https://github.com/froko/dotfiles.git ~/dotfiles
```

Link the files using the `ln -s` command:

```bash
cd ~/dotfiles
ln -s zsh/.zshrc ~/.zshrc
ln -s vim/.vimrc ~/.vimrc

ln -s bat/.config/bat ~/.config/bat
ln -s nvim/.config/nvim ~/.config/nvim
ln -s tmux/.config/tmux ~/.config/tmux
ln -s wezterm/.config/wezterm ~/.config/wezterm
ln -s yazim/.config/yazi ~/.config/yazi
```

Or use [GNU Stow](https://www.gnu.org/software/stow/manual/stow.html) to manage
the symlinks:

```bash
cd ~/dotfiles
stow -R */
```

## Configurations, Plugins, and Keybindings

### zsh

I use [zsh](https://www.zsh.org/) as my shell. The configuration defines the
following aliases:

- `reload`: Reload the `.zshrc` file.
- `c`: Clear the terminal screen.
- `h`: Navigate to the home directory.
- `t`: Start a new tmux session using `sesh connect`.
- `e`: Alias for `yazi`, my preferred file manager.
- `v`: Alias for `nvim`, my preferred text editor.
- `lg`: Alias for `lazygit`, my preferred git client for the terminal.
- `lpath`: Show the current PATH variable.

- `l`: Alias for `eza`, a modern replacement for the `ls` command.
- `ll`: Alias for `eza`, a modern replacement for the `ls` command showing also
  hidden files.

- `..`: Navigate to the parent directory.
- `...`: Navigate to the grandparent directory.
- `....`: Navigate to the great-grandparent directory.

Use `ctrl + r` to search through the command history using `fzf`.

#### zsh plugins

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
  quickly. command with additional features and better defaults. allows you to
  search through files, directories, and command history. ZSH prompt that shows
  the current directory, git status, and more.

### vim

### bat

### nvim

### tmux

### wezterm

### yazi

## Homebrew

If you are on Mac OS, [Homebrew](https://brew.sh/) is the most common package
manager. To install Homebrew, run the following command in your terminal:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Then, install the packages defined in the `Brewfile`:

```bash
brew bundle --file ~/dotfiles/Brewfile
```

### Update Homebrew packages

To update the Homebrew packages, run:

```bash
brew update
brew upgrade
```

To update cask packages, run:

```bash
brew upgrade --cask $(brew list --cask)

```

### Export Homebrew packages to a Brewfile

To export the currently installed Homebrew packages to a `Brewfile`, run:

```bash
brew bundle dump --file ~/dotfiles/Brewfile
```

## References

- [typecraft - The Modern Programmer](https://typecraft.dev/) A great learning
  resource for NeoVim, Tmux, and more.
- [typecraft](https://www.youtube.com/@typecraft_dev) YouTube channel
- [DevOps Toolbox](https://www.youtube.com/@devopstoolbox) YouTube channel
- [Josean Martinez](https://www.youtube.com/@joseanmartinez) YouTube channel
- [Mischa van den Burg](https://www.youtube.com/@mischavandenburg) YouTube
  channel
- [TJ DeVries](https://www.youtube.com/@teej_dv) YouTube channel
- [Sebastian Daschner](https://www.youtube.com/@SebastianDaschnerIT) YouTube
  channel
