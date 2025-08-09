# Homebrew

If you are on Mac OS, [Homebrew](https://brew.sh/) is the most common package
manager. To install Homebrew, run the following command in your terminal:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Then, install the packages defined in the `Brewfile`:

```bash
brew bundle --file ~/dotfiles/Brewfile
```

## Update Homebrew packages

To update the Homebrew packages, run:

```bash
brew update
brew upgrade
```

To update cask packages, run:

```bash
brew upgrade --cask $(brew list --cask)

```

## Export Homebrew packages to a Brewfile

To export the currently installed Homebrew packages to a `Brewfile`, run:

```bash
brew bundle dump --file ~/dotfiles/Brewfile
```

