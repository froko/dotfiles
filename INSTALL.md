# Installation Instructions

This documentation provides instructions for installing the command line
applications configured by this dotfiles repository. Here is a list of all the
applications:

- [zsh](https://www.zsh.org/)
- [bat](https://github.com/sharkdp/bat)
- [eza](https://github.com/eza-community/eza)
- [fzf](https://github.com/junegunn/fzf)
- [lazygit](https://github.com/jesseduffield/lazygit)
- [neovim](https://neovim.io/)
- [sesh](https://github.com/joshmedeski/sesh)
- [stow](https://www.gnu.org/software/stow/)
- [tmux](https://github.com/tmux/tmux/wiki)
- [yazi](https://github.com/sxyazi/yazi)
- [zoxide](https://github.com/ajeetdsouza/zoxide)

In addition, there are a few other resources required by the applications above:

- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
  required by zsh
- [pure prompt](https://github.com/sindresorhus/pure) required by zsh
- [vim-plug](https://github.com/junegunn/vim-plug) required by vim
- [tpm](https://github.com/tmux-plugins/tpm) required by tmux
- [fd](https://github.com/sharkdp/fd) required by neovim
- [luarocks](https://luarocks.org/) required by neovim
- [ripgrep](https://github.com/BurntSushi/ripgrep) required by neovim

## MacOS

[Homebrew](https://brew.sh/) is required to install the applications.

### Basic Applications

Install the basic applications using Homebrew:

```bash
brew install git bat eza fd fzf lazygit luarocks neovim ripgrep stow tmux yazi zoxide joshmedeski/sesh/sesh
```

### zsh Plugins

Install the zsh plugins directly from their repositories:

```bash
git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.zsh/zsh-autosuggestions"
```

### vim Plugin Manager

Install the vim plugin manager via curl:

```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

### tmux Plugin Manager

Install the tmux plugin manager via git:

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

## Linux (Debian/Ubuntu)

### Basic Applications

Install the basic applications using apt:

```bash
sudo apt update
sudo apt install -y bat eza fd-find fzf luarocks ripgrep stow tmux zoxide
```

Create an alias for `batcat` to use it as `bat`:

```bash
ln -s $(which batcat) ~/.bin/bat
```

Create an alias for `fd-find` to use it as `fd`:

```bash
ln -s $(which fdfind) ~/.bin/fd
```

Install lazygit, neovim and yazi using snap:

```bash
sudo snap install lazygit --classic
sudo snap install nvim --classic
sudo snap install yazi --classic
```

Make sure to add the snap bin directory folder to your PATH:

```bash
echo 'export PATH="$PATH:/snap/bin"' >> ~/.zshenv
```

Install sesh from the
[GitHub Release](https://github.com/joshmedeski/sesh/releases/latest) page.
Please replace the version number with the latest version available:

```bash
mkdir -p ~/temp
wget https://github.com/joshmedeski/sesh/releases/download/v2.17.1/sesh_Linux_x86_64.tar.gz -O ~/temp/sesh.tar.gz
tar -xvzf ~/temp/sesh.tar.gz
mv ~/temp/sesh ~/.bin/sesh
rm -rf ~/temp
```

### zsh Plugins

Install the zsh plugins directly from their repositories:

```bash
git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.zsh/zsh-autosuggestions"
```

### vim Plugin Manager

Install the vim plugin manager via curl:

```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

### tmux Plugin Manager

Install the tmux plugin manager via git:

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

## Linux (Arch)

This instruction assumes you have installed a brand new Arch Linux for WSL2.
Before proceeding, let's provide a basic environment. If you already have a
working Arch Linux installation, you can skip this section.

Set a new password for the root user:

```bash
passwd
```

Install some basic stuff:

```bash
pacman -Syu git sudo vim wget which zsh
```

Set a locale for the system by editing `/etc/locale.gen` and uncommenting the
desired locale, for example:

```bash
en_US.UTF-8 UTF-8
```

Then generate the locale:

```bash
locale-gen
```

Set the timezone by creating a symlink to the desired timezone file in
`/usr/share/zoneinfo`, for example:

```bash
ln -sf /usr/share/zoneinfo/Europe/Zurich /etc/localtime
```

Create a new sudo group:

```bash
groupadd sudo
```

Edit the `'etc/sudors'` file and uncomment the following lines:

```bash
%wheel ALL=(ALL) NOPASSWD: ALL
%sudo ALL=(ALL) ALL
```

Add a new user to the system with the sudo group and zsh as the default shell:

```bash
useradd -m -G wheel,sudo -s /bin/zsh yourusername
```

Set a password for the new user:

```bash
passwd yourusername
```

Leave the wsl instance and set the default user to the new user you just created
by running the following command in PowerShell:

```powershell
wsl --manage archlinux --set-default-user yourusername
```

### Basic Applications

Install the basic applications using pacman:

```bash
sudo pacman -Syu eza fd fzf lazygit luarocks neovim ripgrep stow tmux yazi zoxide
```

Install sesh from the
[GitHub Release](https://github.com/joshmedeski/sesh/releases/latest) page.
Please replace the version number with the latest version available:

```bash
mkdir -p ~/temp
wget https://github.com/joshmedeski/sesh/releases/download/v2.17.1/sesh_Linux_x86_64.tar.gz -O ~/temp/sesh.tar.gz
tar -xvzf ~/temp/sesh.tar.gz
mv ~/temp/sesh ~/.bin/sesh
rm -rf ~/temp
```

### zsh Plugins

Install the zsh plugins directly from their repositories:

```bash
git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
git clone https://github.com/zsh-users/zsh-autosuggestions "$HOME/.zsh/zsh-autosuggestions"
```

### vim Plugin Manager

Install the vim plugin manager via curl:

```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

### tmux Plugin Manager

Install the tmux plugin manager via git:

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```
