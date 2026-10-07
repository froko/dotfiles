# bin

A handful of personal helper scripts. They are stowed into `~/.bin`, which
`.zshrc` prepends to `PATH`, so they are callable by name from anywhere.

```bash
cd ~/dotfiles
stow bin
```

## Scripts

### `brew-why`

Lists every installed Homebrew formula together with the formulae that depend on
it. Useful for working out whether something is safe to uninstall:

```bash
brew-why
```

### `workspace-init.sh`

Launches the applications that make up a working session: Google Chrome, Slack,
WezTerm and GitKraken. Bound to `alt-shift-i` in
[AeroSpace](../aerospace/README.md).

### `workspace-shutdown.sh`

Asks the session applications to quit, but only those actually running. It also
covers Brave Browser, so either browser is closed. Bound to `alt-shift-q` in
[AeroSpace](../aerospace/README.md).

Both workspace scripts hold their own hard-coded application list — edit them
when your toolset changes.
