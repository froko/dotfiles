eval "$(starship init bash)"

alias reload='RELOAD=1 source ~/.bashrc'

alias c="clear"
alias h="cd ~"
alias w="cd /workspaces"
alias v="/opt/homebrew/bin/nvim"
alias g="git"
alias n="npm"
alias p="pnpm"
alias lg="lazygit"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias lpath='echo $PATH | tr ":" "\n"'

export VISUAL=nvim
export EDITOR=nvim
export TERM=screen-256color

eval "$(fzf --bash)"

