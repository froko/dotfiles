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
- [ripgrep](https://github.com/BurntSushi/ripgrep) required by neovim

## MacOS

[Homebrew](https://brew.sh/) is required to install the applications.

### Basic Applications

Install the basic applications using Homebrew:

```bash
brew install git bat eza fd fzf lazygit neovim ripgrep stow tmux yazi zoxide joshmedeski/sesh/sesh
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

The following instructions assume a WSL2 instance with a fresh Debian or Ubuntu
installation. If you already have a working Debian or Ubuntu installation, you
may skip some of the steps.

It turned out that the `fzf` package for the current Ubuntu LTS version (24.04)
is outdated, so you need to install the version 25.04. You find the base image
here:
[https://releases.ubuntu.com/plucky/ubuntu-25.04-wsl-amd64.wsl](https://releases.ubuntu.com/plucky/ubuntu-25.04-wsl-amd64.wsl).

After downloading the base image, you can just double-click the downloaded wsl
file to import it into WSL2.

### Basic Applications

Install the basic applications using apt:

```bash
sudo apt update
sudo apt install -y bat eza fd-find fzf gcc libicu-dev ripgrep stow tmux unzip zoxide zsh
```

Change the default shell to zsh for your user:

```bash
chsh -s $(which zsh)
```

Create aliases for `batcat` and `fd-find`:

```bash
mkdir -p ~/.bin \
  && ln -s $(which batcat) ~/.bin/bat \
  && ln -s $(which fdfind) ~/.bin/fd
```

Install ['nvm'](https://github.com/nvm-sh/nvm)

```bash
PROFILE=/dev/null bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash'
```

Add the following lines to your `~/.zprofile` file to load nvm automatically:

```bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
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
tar -xvzf ~/temp/sesh.tar.gz -C ~/temp
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

### Post-Installation Actions

After a new login, install the lts version of Node.js using nvm:

```bash
nvm install --lts
```

Once you have cloned the dotfiles repository and linked the configurations, you
can apply them to the following applications:

- `bat`: run `bat cache --build`
- `tmux`: After starting tmux, press `<c-a> I` to install the tmux plugins.
- `nvim`: The plugins will be installed automatically when you open nvim for the
  first time.
- `vim`: After starting vim, run `:PlugInstall` to install the vim plugins. You
  may need to confirm the first error message.

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
%wheel ALL=(ALL:ALL) NOPASSWD: ALL
%sudo ALL=(ALL:ALL) ALL
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
sudo pacman -Syu bat eza fd fzf gcc lazygit neovim ripgrep stow tmux yazi zoxide zsh
```

Install ['nvm'](https://github.com/nvm-sh/nvm)

```bash
PROFILE=/dev/null bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash'
```

Add the following lines to your `~/.zprofile` file to load nvm automatically:

```bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
```

Install sesh from the
[GitHub Release](https://github.com/joshmedeski/sesh/releases/latest) page.
Please replace the version number with the latest version available:

```bash
mkdir -p ~/temp
wget https://github.com/joshmedeski/sesh/releases/download/v2.17.1/sesh_Linux_x86_64.tar.gz -O ~/temp/sesh.tar.gz
tar -xvzf ~/temp/sesh.tar.gz -C ~/temp
mkdir -p ~/.bin && mv ~/temp/sesh ~/.bin/sesh
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

### Post-Installation Actions

After a new login, install the lts version of Node.js using nvm:

```bash
nvm install --lts
```

Once you have cloned the dotfiles repository and linked the configurations, you
can apply them to the following applications:

- `bat`: run `bat cache --build`
- `tmux`: After starting tmux, press `<c-a> I` to install the tmux plugins.
- `nvim`: The plugins will be installed automatically when you open nvim for the
  first time.
- `vim`: After starting vim, run `:PlugInstall` to install the vim plugins. You
  may need to confirm the first error message.
