#!/bin/bash

# Set the default path or use the environment variable JOURNAL_PATH
FILE_PATH="${JOURNAL_PATH:-$HOME/JOURNAL.md}"

# Get the current date in YYYY-MM-DD format
CURRENT_DATE=$(date +"%Y-%m-%d")

# Capture the note (all arguments passed to the script)
NOTE_TEXT="$*"

# If no text was provided, exit
if [ -z "$NOTE_TEXT" ]; then
    echo "Usage: note your message here"
    exit 1
fi

# Ensure the file exists
touch "$FILE_PATH"

# Check if the current date heading already exists in the file
if ! grep -q "## $CURRENT_DATE" "$FILE_PATH"; then
    # Add a newline and the new date header if not found
    echo -e "\n## $CURRENT_DATE" >> "$FILE_PATH"
fi

# Append the note with a timestamp
echo "* $(date +"%H:%M"): $NOTE_TEXT" >> "$FILE_PATH"
