# Installation Instructions

This documentation provides instructions for installing the command line
applications configured by this dotfiles repository. Here is a list of all the
applications:

- [zsh](https://www.zsh.org/)
- [bat](https://github.com/sharkdp/bat)
- [delta](https://dandavison.github.io/delta/)
- [eza](https://github.com/eza-community/eza)
- [fzf](https://github.com/junegunn/fzf)
- [hunk](https://www.hunk.dev/)
- [just](https://github.com/casey/just)
- [lazygit](https://github.com/jesseduffield/lazygit)
- [neovim](https://neovim.io/) — **0.12 or newer required**
- [`presenterm`](https://mfontanini.github.io/presenterm/)
- [sesh](https://github.com/joshmedeski/sesh)
- [stow](https://www.gnu.org/software/stow/)
- [tmux](https://github.com/tmux/tmux/wiki)
- [yazi](https://github.com/sxyazi/yazi)
- [zk](https://github.com/zk-org/zk)
- [zoxide](https://github.com/ajeetdsouza/zoxide)

In addition, there are a few other resources required by the applications above:

- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
  required by zsh
- [pure prompt](https://github.com/sindresorhus/pure) required by zsh
- [vim-plug](https://github.com/junegunn/vim-plug) required by vim
- [tpm](https://github.com/tmux-plugins/tpm) required by tmux
- [fd](https://github.com/sharkdp/fd) required by neovim and the zsh `fzf`
  integration
- [ripgrep](https://github.com/BurntSushi/ripgrep) required by neovim and the
  zsh `fzf` integration

## MacOS

[Homebrew](https://brew.sh/) is required to install the applications.

### Basic Applications

All packages — formulae and casks alike — are declared in the
[`Brewfile`](Brewfile) at the root of this repository. Install them in one go:

```bash
brew bundle --file ~/dotfiles/Brewfile
```

See the [Homebrew documentation](homebrew/README.md) for installing Homebrew
itself, updating packages, and regenerating the `Brewfile`.

### vim Plugin Manager

Install the vim plugin manager via curl:

```bash
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

### tmux Plugin Manager

Install the tmux plugin manager via git:

```bash
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
```

> **Note:** the path matters. Because `tmux.conf` lives at the XDG location, tpm
> sets `TMUX_PLUGIN_MANAGER_PATH` to `~/.config/tmux/plugins/` and installs
> every plugin there. Cloning tpm itself to `~/.tmux/plugins/tpm` would leave
> the bootstrap in one tree and the plugins it manages in another.

### Post-Installation Actions

Once you have cloned the dotfiles repository and linked the configurations, you
can apply them to the following applications:

- `bat`: run `bat cache --build` so the bundled Catppuccin themes are picked up.
- `tmux`: After starting tmux, press `<c-a> I` to install the tmux plugins.
- `nvim`: The plugins will be installed automatically when you open nvim for the
  first time.
- `vim`: After starting vim, run `:PlugInstall` to install the vim plugins. You
  may need to confirm the first error message.

## Linux (Debian/Ubuntu)

> [!WARNING]
> **This section was generated with AI assistance and has not been tested on a
> live system.** It was rewritten from an older, outdated version against
> current upstream documentation and package indexes, but no part of it has been
> run end to end. Expect errors, omissions and version drift — verify each
> command before trusting it, and treat the package availability notes as a
> starting point rather than fact. The macOS section above is the only one in
> active use.

The following instructions assume a WSL2 instance with a fresh Debian or Ubuntu
installation. If you already have a working installation, you may skip some of
the steps.

Ubuntu 26.04 LTS ("Resolute Raccoon") or newer is recommended: earlier releases
shipped an `fzf` too old for the configuration in this repository. The WSL base
images are available from [releases.ubuntu.com](https://releases.ubuntu.com/).
After downloading, you can double-click the `.wsl` file to import it into WSL2.

### Basic Applications

Most of the tooling is in the Ubuntu archive as of 26.04. Enable the `universe`
repository if it is not already, then install:

```bash
sudo apt update
sudo apt install -y \
  bat eza fd-find fzf git-delta just lazygit ripgrep stow tmux zoxide zsh \
  curl gcc git libicu-dev unzip
```

Change the default shell to zsh for your user:

```bash
chsh -s $(which zsh)
```

Debian and Ubuntu ship `bat` as `batcat` and `fd` as `fdfind` to avoid name
clashes. Create aliases so the configuration finds them under the expected
names:

```bash
mkdir -p ~/.bin \
  && ln -s $(which batcat) ~/.bin/bat \
  && ln -s $(which fdfind) ~/.bin/fd
```

### Neovim (0.12 or newer required)

The configuration in this repository uses `vim.pack`, which needs **Neovim
0.12+**. Do not install Neovim from `apt` or from the `neovim-ppa/stable` PPA:
both lag far behind (the PPA has not been updated since 2022) and will be too
old.

Use the snap, which tracks stable releases:

```bash
sudo snap install nvim --classic
```

Alternatively, install the official pre-built tarball, which avoids snapd
entirely:

```bash
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim-linux-x86_64
sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz
rm nvim-linux-x86_64.tar.gz
echo 'export PATH="$PATH:/opt/nvim-linux-x86_64/bin"' >> ~/.zshenv
```

Verify you are on a supported version before going further:

```bash
nvim --version | head -1   # expect v0.12.0 or newer
```

### Remaining Applications

`yazi`, `zk`, `sesh`, `hunk` and `presenterm` are not in the Ubuntu archive.
Install the ones you need from snap:

```bash
sudo snap install yazi --classic
sudo snap install zk --classic
```

Make sure the snap bin directory is on your PATH:

```bash
echo 'export PATH="$PATH:/snap/bin"' >> ~/.zshenv
```

Install `sesh` from its
[latest GitHub release](https://github.com/joshmedeski/sesh/releases/latest).
Check that page for the current version and asset name rather than copying a
version number from here:

```bash
SESH_VERSION=2.32.0   # check the releases page for the current version
mkdir -p ~/.bin ~/temp
curl -L "https://github.com/joshmedeski/sesh/releases/download/v${SESH_VERSION}/sesh_Linux_x86_64.tar.gz" -o ~/temp/sesh.tar.gz
tar -xzf ~/temp/sesh.tar.gz -C ~/temp
mv ~/temp/sesh ~/.bin/sesh
rm -rf ~/temp
```

`hunk` provides an official install script:

```bash
curl -fsSL https://hunk.dev/install.sh | sh
```

`presenterm` publishes Linux binaries on its
[releases page](https://github.com/mfontanini/presenterm/releases) and can be
installed the same way as `sesh` above, or via `cargo install presenterm` if you
have a Rust toolchain.

### Node.js

Install [nvm](https://github.com/nvm-sh/nvm), checking its repository for the
current installer version:

```bash
PROFILE=/dev/null bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash'
```

Add the following lines to your `~/.zprofile` file to load nvm automatically:

```bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
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
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
```

> **Note:** the path matters. Because `tmux.conf` lives at the XDG location, tpm
> sets `TMUX_PLUGIN_MANAGER_PATH` to `~/.config/tmux/plugins/` and installs
> every plugin there. Cloning tpm itself to `~/.tmux/plugins/tpm` would leave
> the bootstrap in one tree and the plugins it manages in another.

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

> [!WARNING]
> **This section was generated with AI assistance and has not been tested on a
> live system.** It was rewritten from an older, outdated version against
> current upstream documentation and package indexes, but no part of it has been
> run end to end. Expect errors, omissions and version drift — verify each
> command before trusting it. The macOS section above is the only one in active
> use.

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

Then generate the locale and set it system-wide:

```bash
locale-gen
echo 'LANG=en_US.UTF-8' > /etc/locale.conf
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

Grant that group sudo rights. Edit the sudoers file with `visudo`, which
validates the syntax before saving — a malformed `/etc/sudoers` can lock you
out of `sudo` entirely:

```bash
EDITOR=vim visudo
```

Uncomment the following lines:

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

Arch tracks upstream closely, so almost everything — including a current
Neovim — comes straight from the official repositories:

```bash
sudo pacman -Syu \
  bat eza fd fzf git-delta just lazygit neovim presenterm ripgrep \
  stow tmux yazi zoxide zk zsh \
  curl gcc git unzip
```

Confirm Neovim is 0.12 or newer, which the configuration in this repository
requires:

```bash
nvim --version | head -1   # expect v0.12.0 or newer
```

`hunk` is not in the official repositories; use its install script:

```bash
curl -fsSL https://hunk.dev/install.sh | sh
```

Install [nvm](https://github.com/nvm-sh/nvm), checking its repository for the
current installer version:

```bash
PROFILE=/dev/null bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/master/install.sh | bash'
```

Add the following lines to your `~/.zprofile` file to load nvm automatically:

```bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
```

Install `sesh` from its
[latest GitHub release](https://github.com/joshmedeski/sesh/releases/latest).
Check that page for the current version and asset name rather than copying a
version number from here:

```bash
SESH_VERSION=2.32.0   # check the releases page for the current version
mkdir -p ~/.bin ~/temp
curl -L "https://github.com/joshmedeski/sesh/releases/download/v${SESH_VERSION}/sesh_Linux_x86_64.tar.gz" -o ~/temp/sesh.tar.gz
tar -xzf ~/temp/sesh.tar.gz -C ~/temp
mv ~/temp/sesh ~/.bin/sesh
rm -rf ~/temp
```

`sesh` is also available from the AUR as `sesh-bin` if you use an AUR helper.

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
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
```

> **Note:** the path matters. Because `tmux.conf` lives at the XDG location, tpm
> sets `TMUX_PLUGIN_MANAGER_PATH` to `~/.config/tmux/plugins/` and installs
> every plugin there. Cloning tpm itself to `~/.tmux/plugins/tpm` would leave
> the bootstrap in one tree and the plugins it manages in another.

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
