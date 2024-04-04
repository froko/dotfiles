source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

alias reload='RELOAD=1 source ~/.zshrc'

alias c="clear"
alias h="cd ~"
alias t='sesh connect $(sesh list | fzf)'
alias v="/opt/homebrew/bin/nvim"

alias cd="z"

alias l="eza --icons --git --long"
alias ll="eza --icons --git --all --long"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias lpath='echo $PATH | tr ":" "\n"'
