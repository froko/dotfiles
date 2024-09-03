# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Plugins ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source <(fzf --zsh)



# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Environment Variables ~~~~~~~~~~~~~~~~~~~~~~~~~~~

set -o vi

export VISUAL=nvim
export EDITOR=nvim
export TERM="tmux-256color"

export BROWSER="arc"
export BAT_THEME="Catppuccin Mocha"

export DOTFILES="$HOME/.dotfiles"
export PNPM_HOME="/Users/patrickineichen/.local/share/pnpm/store/v3"



# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Path Configuration ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

setopt extended_glob null_glob

path=(
  $path
  $HOME/.bin
  $PNPM_HOME
)

typeset -U path
path=($^path(N-/))

export PATH



# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ History ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY



# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Prompt ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

PURE_GIT_PULL=0

fpath+=("$(brew --prefix)/share/zsh/site-functions")

autoload -U promptinit; promptinit
prompt pure

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~ fzf Configuration ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_DEFAULT_OPTS=" \
--color=spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"


export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"



# ~~~~~~~~~~~~~~~~~~~~~~~~ Aliases ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

alias reload='RELOAD=1 source ~/.zshrc'

alias c="clear"
alias h="cd ~"
alias t='sesh connect $(sesh list | fzf)'
alias v="/opt/homebrew/bin/nvim"
alias e="yazi"
alias lg="lazygit"
alias oo="cd ~/Work/2ndBrain && nvim"

alias l="eza --icons --git --long"
alias ll="eza --icons --git --all --long"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias lpath='echo $PATH | tr ":" "\n"'

# pnpm
export PNPM_HOME="/Users/patrickineichen/.local/share/pnpm/store/v3"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
