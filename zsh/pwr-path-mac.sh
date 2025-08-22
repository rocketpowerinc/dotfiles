#!/usr/bin/env zsh


#* Moving the Dotfile
clear
# Define source and destination paths
SOURCE="$HOME/Downloads/Temp/dotfiles/zsh/zshrc"
DESTINATION="$HOME/Dotfiles/zsh/zshrc"

# Ensure destination directory exists
DESTDIR=$(dirname "$DESTINATION")
if [ ! -d "$DESTDIR" ]; then
    mkdir -p "$DESTDIR"
fi

# Copy the file (overwrite if it exists)
cp -f "$SOURCE" "$DESTINATION"

# Print success message in green
echo -e "\033[0;32mFile copied successfully to $DESTINATION\033[0m"



#* Making Sure the Source Path Line exist in Main ZSHRC

TARGET="$HOME/.zshrc"
LINE="source \"$HOME/Dotfiles/zsh/zshrc\""

if grep -qxF "$LINE" "$TARGET"; then
    printf '\033[33m%s\033[0m\n' ".zshrc is already sourced!"   # yellow
else
    echo "$LINE" >> "$TARGET"
    printf '\033[32m%s\033[0m\n' ".zshrc has been sourced!"     # green
fi
