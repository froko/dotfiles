# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Environment Variables ~~~~~~~~~~~~~~~~~~~~~~~~~~~

set -o vi

export VISUAL=nvim
export EDITOR=nvim
export BAT_THEME="Catppuccin Mocha"
export DOTFILES="$HOME/dotfiles"
export NOTES="$HOME/notes"
export PRESENTERM_CONFIG_FILE="$HOME/.config/presenterm/config.yaml"
export PATH="$HOME/.bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

setopt extended_glob null_glob
typeset -U path
path=($^path(N-/))

export PATH

# Place environment variables that relate to your package manager or to a custom
# diretory here: ~/.zshprofile or ~/.zshenv



# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Plugins ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source <(fzf --zsh)
eval "$(zoxide init zsh)"



# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ History ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

setopt append_history
setopt share_history
setopt hist_ignore_dups
setopt hist_expire_dups_first
setopt hist_find_no_dups
setopt hist_reduce_blanks
setopt inc_append_history


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Prompt ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

PURE_GIT_PULL=0

fpath+=("$(brew --prefix)/share/zsh/site-functions")

autoload -U promptinit; promptinit
prompt pure



# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ fzf Configuration ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

_fzf_compgen_path() {
  fd --hidden --exclude .git . "${1:-.}"
}

_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "${1:-.}"
}

show_file_or_dir_preview="if [ -d '{}' ]; then eza --tree --level=3 --color=always -- '{}' | head -n 200; else bat -n --color=always --line-range :500 -- '{}'; fi"

export FZF_DEFAULT_OPTS=" \
--color=bg+:#363a4f,spinner:#f4dbd6,hl:#ed8796 \
--color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
--color=marker:#b7bdf8,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796 \
--color=selected-bg:#494d64 \
--color=border:#6e738d,label:#cad3f5"

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"


export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --level=3 --color=always -- {} | head -n 200'"

ff() {
  fzf --query="$1" \
      --preview 'bat --style=numbers --color=always --line-range :500 {}' \
      --bind 'enter:become(nvim {1} +{2})'
}

fg() {
  RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
  INITIAL_QUERY="${*:-}"
  fzf --ansi --disabled --query "$INITIAL_QUERY" \
      --bind "start:reload:$RG_PREFIX {q} || true" \
      --bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
      --delimiter : \
      --preview 'bat --color=always {1} --highlight-line {2}' \
      --preview-window '+{2}+3/3,~3' \
      --bind 'enter:become(nvim {1} +{2})'
}

# ~~~~~~~~~~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

alias reload='RELOAD=1 source ~/.zshrc'

alias c="clear"
alias t='sesh connect $(sesh list | fzf)'
alias v="nvim"
alias e="yazi"
alias lg="lazygit"
alias dot="cd $DOTFILES && nvim"
alias notes="cd $NOTES && zk edit -i"
alias note='~/.bin/note.sh'
alias daily="zk daily"

alias l="eza --icons --git --long"
alias ll="eza --icons --git --all --long"
alias tree="eza --icons --git-ignore --tree --all --level=3"

alias cd="z"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias lpath='echo $PATH | tr ":" "\n"'

just() {
  if [ -f ./justfile ] || [ -f ./.justfile ]; then
    command just "$@"
  else
    command just --global-justfile "$@"
  fi
}

# ~~~~~~~~~~~~~~~~~~~~~~~~ Git Aliases ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Short status with the branch header and ahead/behind counts, plus a reminder
# of how many stash entries exist.
alias gs="git status -sb --show-stash"

# Fetch from every remote, including tags, and delete remote-tracking refs for
# branches that no longer exist upstream.
alias gfa="git fetch --all --tags --prune"

# Git log with graph, one line per commit, decorated with branch and tag names,
# showing all commits including boundaries, and always using color.
alias glog="git log --graph --oneline --decorate --all --boundary --color=always"

# Drop any stale aliases so re-sourcing this file can redefine the functions;
# zsh expands an existing alias before it parses `name()`.
unalias gco gdiff 2>/dev/null

# Checkout a branch picked from all local and remote branches, newest first.
gco() {
  local branch
  branch=$(git branch -a --sort=-committerdate |
    grep -v '/HEAD' |
    fzf |
    sed -e 's/^[ *]*//' -e 's|^remotes/origin/||') || return
  [ -n "$branch" ] || return
  git checkout "$branch"
}

# Pick a commit from the log and review it hunk by hunk.
gdiff() {
  local line sha
  line=$(glog "$@" |
    fzf --ansi --no-sort --reverse --tiebreak=index \
      --header 'select a commit to review in hunk' \
      --preview 's=$(printf %s {} | grep -oE "[0-9a-f]{7,}" | head -1); [ -n "$s" ] && git show --color=always --stat "$s"' \
      --preview-window 'right,50%,wrap') || return
  sha=$(printf %s "$line" | grep -oE '[0-9a-f]{7,}' | head -1)
  [ -n "$sha" ] || return
  hunk show "$sha"
}
