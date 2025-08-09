# My dot files

## Installation

Please refer to the [INSTALL.md](INSTALL.md) file for detailed application
installation instructions.

Clone the repository to your home directory:

```bash
git clone https://github.com/froko/dotfiles.git ~/dotfiles
```

To make it your own, you can fork the repository first and then clone your fork.

Link the files using the `ln -s` command:

```bash
cd ~/dotfiles
ln -s zsh/.zshrc ~/.zshrc
ln -s vim/.vimrc ~/.vimrc
ln -s bat/.config/bat ~/.config/bat
ln -s nvim/.config/nvim ~/.config/nvim
ln -s tmux/.config/tmux ~/.config/tmux
ln -s yazi /.config/yazi ~/.config/yazi
ln -s wezterm/.config/wezterm ~/.config/wezterm
```

Or use [GNU Stow](https://www.gnu.org/software/stow/manual/stow.html) to manage
the symlinks:

```bash
cd ~/dotfiles
stow bat nvim tmux vim yazi zsh
stow wezterm
```

## Documentation

For detailed documentation refer to the individual README files in their config
directories:

- [bat](bat/.config/bat/README.md)
- [nvim](nvim/.config/nvim/README.md)
- [tmux](tmux/.config/tmux/README.md)
- [vim](vim/README.md)
- [wezterm](wezterm/.config/wezterm/README.md)
- [yazi](yazi/.config/yazi/README.md)
- [zsh](zsh/README.md)
- [Homebrew](/homebrew/README.md)

## References

- [typecraft - The Modern Programmer](https://typecraft.dev/) A great learning
  resource for NeoVim, Tmux, and more.
- [typecraft](https://www.youtube.com/@typecraft_dev) YouTube channel
- [DevOps Toolbox](https://www.youtube.com/@devopstoolbox) YouTube channel
- [Coding with Sphere](https://www.youtube.com/@codingwithsphere) YouTube
  channel
- [Josean Martinez](https://www.youtube.com/@joseanmartinez) YouTube channel
- [Mischa van den Burg](https://www.youtube.com/@mischavandenburg) YouTube
  channel
- [TJ DeVries](https://www.youtube.com/@teej_dv) YouTube channel
- [Sebastian Daschner](https://www.youtube.com/@SebastianDaschnerIT) YouTube
  channel
- [Marco Peluso](https://www.youtube.com/@marco_peluso) YouTube channel
- [The Primeagen](https://www.youtube.com/@ThePrimeagen) YouTube channel
