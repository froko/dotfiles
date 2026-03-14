#!/bin/zsh

# List of apps to launch
apps=(
  "Google Chrome"
  "Slack"
  "WezTerm"
  "Zed"
  "GitKraken"
)

for app in "${apps[@]}"; do
  open -a "$app"
done
