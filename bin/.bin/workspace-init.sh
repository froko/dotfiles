#!/bin/zsh

# List of apps to launch
apps=(
  "Google Chrome"
  "Slack"
  "WezTerm"
  "GitKraken"
)

for app in "${apps[@]}"; do
  open -a "$app"
done
