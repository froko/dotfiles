#!/bin/bash

# List of app names exactly as they appear in your Applications folder.
# Both browsers are listed so whichever one is running gets closed.
apps=("Google Chrome" "Brave Browser" "Slack" "WezTerm" "GitKraken")

for app in "${apps[@]}"; do
    # This tells the app to quit only if it is actually running
    osascript -e "if application \"$app\" is running then tell application \"$app\" to quit"
done

echo "Apps have been requested to close."
