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

### `note.sh`

Appends a timestamped entry to a journal file, creating today's date heading if
it does not exist yet. Aliased to `note` in `.zshrc`:

```bash
note Picked up the release review again
```

The target file is `$JOURNAL_PATH`, falling back to `~/JOURNAL.md`. To keep
entries alongside your `zk` notes, point it at your notebook — for example in
`~/.zprofile`:

```bash
export JOURNAL_PATH="$HOME/notes/JOURNAL.md"
```

> **Note:** the global justfile also provides a `just note` recipe that writes
> to `$NOTES/JOURNAL.md`. The two are independent — pick one and stick with it,
> or set `JOURNAL_PATH` to the same file so they agree.

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
