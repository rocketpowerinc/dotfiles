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
# Path to pwsh profile (adjust if needed for your system)
PROFILE_PATH="$HOME/.config/powershell/Microsoft.PowerShell_profile.ps1"
DOTFILES_PATH="$HOME/Dotfiles/pwsh/profile.ps1"
SOURCE_LINE=". \"$DOTFILES_PATH\""

# Check if $PROFILE_PATH is defined
if [ -z "$PROFILE_PATH" ]; then
    echo -e "\033[0;31mError: PROFILE_PATH is null. Cannot update profile. Make sure to be running this in a proper shell session.\033[0m"
    exit 1
fi

# Ensure profile directory exists
PROFILE_DIR=$(dirname "$PROFILE_PATH")
if [ ! -d "$PROFILE_DIR" ]; then
    mkdir -p "$PROFILE_DIR"
fi

# Ensure the profile.ps1 file exists
if [ ! -f "$PROFILE_PATH" ]; then
    touch "$PROFILE_PATH"
fi

# Check if the profile already sources the dotfiles profile
if ! grep -Fxq "$SOURCE_LINE" "$PROFILE_PATH"; then
    echo "$SOURCE_LINE" >> "$PROFILE_PATH"
    echo -e "\033[0;32mpwsh profile has been sourced!\033[0m"
else
    echo -e "\033[0;33mpwsh profile already sourced!\033[0m"
fi