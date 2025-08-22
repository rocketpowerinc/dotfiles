#!/usr/bin/env bash


#* Moving the Dotfile
clear
# Define source and destination paths
SOURCE="$HOME/Downloads/Temp/dotfiles/bash/bashrc"
DESTINATION="$HOME/Dotfiles/bash/.bashrc"

# Ensure destination directory exists
DESTDIR=$(dirname "$DESTINATION")
if [ ! -d "$DESTDIR" ]; then
    mkdir -p "$DESTDIR"
fi

# Copy the file (overwrite if it exists)
cp -f "$SOURCE" "$DESTINATION"

# Print success message in green
echo -e "\033[0;32mFile copied successfully to $DESTINATION\033[0m"



#* Making Sure the Source Path Line exist in BashRC
