#!/usr/bin/env bash
set -e


# Install Dependencies
sudo apt update && sudo apt install just yad

TMPDIR="$(mktemp -d)"
trap 'rm -rf "$TMPDIR"' EXIT

git clone --depth 1 https://github.com/rocketpowerinc/dotfiles.git "$TMPDIR"

# Copy justfile to $HHOME
install -m 777 \
  "$TMPDIR/anduinos/justfile" \
  "$HOME/justfile"

# Copy justfile yad gui to $HOME
install -m 777 \
  "$TMPDIR/anduinos/justfile-gui.sh" \
  "$HOME/justfile-gui.sh"
chmod +x "$HOME/justfile-gui.sh"


# Download Icon
mkdir -p ~/.local/share/icons && \
curl -L "https://raw.githubusercontent.com/Anduin2017/AnduinOS/47ef341b4ab9119905e3abcfd1949d718698ac14/src/mods/30-gnome-extension-arcmenu-patch/logo.svg" \
-o ~/.local/share/icons/anduinos-logo.svg


#!####################################################
#! Desktop icon + start at boot + add to app drawer  #
#!####################################################


# 1. Define the target paths
DESKTOP_DIR="$HOME/Desktop"
APPS_DIR="$HOME/.local/share/applications"
AUTOSTART_DIR="$HOME/.config/autostart"
FILE_NAME="Anduinos-Toolkit.desktop"
SCRIPT_PATH="/home/$USER/justfile-gui.sh"
LOG_PATH="/home/$USER/toolkit_debug.log"

# 2. Create directories if they don't exist
mkdir -p "$APPS_DIR"
mkdir -p "$AUTOSTART_DIR"

# 3. Create the standard .desktop file (for Desktop and App Menu)
cat <<EOF > "/tmp/$FILE_NAME"
[Desktop Entry]
Version=1.0
Name=AnduinOS Toolkit
Exec=/usr/bin/bash $SCRIPT_PATH
Icon=/home/$USER/.local/share/icons/anduinos-logo.svg
Terminal=false
Type=Application
Categories=Utility;System;
Comment=Manage your system with Justfile
StartupNotify=true
EOF

# 4. Create a specific Autostart version with a delay and debug logging
# This uses 'sh -c' to allow the sleep and redirection to work
cat <<EOF > "/tmp/autostart-$FILE_NAME"
[Desktop Entry]
Version=1.0
Name=AnduinOS Toolkit (Autostart)
Exec=/usr/bin/sh -c "sleep 5 && /usr/bin/bash $SCRIPT_PATH > $LOG_PATH 2>&1"
Icon=/home/$USER/.local/share/icons/anduinos-logo.svg
Terminal=false
Type=Application
Categories=Utility;System;
Comment=Launch Toolkit at boot
StartupNotify=false
EOF

# 5. Copy files to their specific locations
cp "/tmp/$FILE_NAME" "$DESKTOP_DIR/$FILE_NAME"
cp "/tmp/$FILE_NAME" "$APPS_DIR/$FILE_NAME"
cp "/tmp/autostart-$FILE_NAME" "$AUTOSTART_DIR/$FILE_NAME"

# 6. Make them all executable
chmod +x "$DESKTOP_DIR/$FILE_NAME"
chmod +x "$APPS_DIR/$FILE_NAME"
chmod +x "$AUTOSTART_DIR/$FILE_NAME"
chmod +x "$SCRIPT_PATH"

echo "Installation complete!"
echo "------------------------------------------------"
echo "1. Desktop Icon: Created"
echo "2. App Menu Icon: Created"
echo "3. Autostart: Set with 5s delay and debug log"
echo "------------------------------------------------"
echo "If it fails on next reboot, check: cat $LOG_PATH"