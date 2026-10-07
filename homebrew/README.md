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

## What the Brewfile represents

The `Brewfile` is a curated declaration of what a freshly set up machine should
have — not a mirror of any one machine. It therefore lists applications that may
not be installed on the machine you are reading this from.

As a consequence, `brew bundle check` will usually report unmet dependencies.
That is expected and not a defect: use it to see what a fresh install would
still pull in, and `brew bundle install` to actually install them.

```bash
brew bundle check --verbose --file ~/dotfiles/Brewfile
```

Because of this, prefer editing the `Brewfile` by hand when adding or removing a
package. Regenerating it with `brew bundle dump` (see below) overwrites the
curated list with whatever happens to be installed locally.

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
brew bundle dump --file ~/dotfiles/Brewfile --force
```

> **Note:** this replaces the curated `Brewfile` with an exact snapshot of the
> current machine, dropping anything not installed here. Review the diff before
> committing.
