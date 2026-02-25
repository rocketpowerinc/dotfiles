#!/usr/bin/env bash
set -e


# Install Dependencies
sudo apt update && sudo apt install just yad

TMPDIR="$(mktemp -d)"
trap 'rm -rf "$TMPDIR"' EXIT

git clone --depth 1 https://github.com/rocketpowerinc/dotfiles.git "$TMPDIR"

# Copy justfile to $HHOME
install -m 777 \
  "$TMPDIR/cachyos/justfile" \
  "$HOME/justfile"

# Copy justfile yad gui to $HOME
install -m 777 \
  "$TMPDIR/cachyos/justfile-gui.sh" \
  "$HOME/justfile-gui.sh"
chmod +x "$HOME/justfile-gui.sh"


# Download Icon
mkdir -p ~/.local/share/icons && \
curl -L "https://github.com/CachyOS/calamares-config/blob/grub-3.2/etc/calamares/branding/cachyos/logo.png?raw=true" \
-o ~/.local/share/icons/cachyos-logo.svg


#!####################################################
#! Desktop icon + start at boot + add to app drawer  #
#!####################################################

set -e

# 1. Define the target paths
DESKTOP_DIR="$HOME/Desktop"
APPS_DIR="$HOME/.local/share/applications"
AUTOSTART_DIR="$HOME/.config/autostart"
FILE_NAME="CachyOS-Toolkit.desktop"
SCRIPT_PATH="/home/$USER/justfile-gui.sh"

# 2. Create directories if they don't exist
mkdir -p "$APPS_DIR"
mkdir -p "$AUTOSTART_DIR"
mkdir -p "$DESKTOP_DIR"

# 3. Remove any existing files (guaranteed clean overwrite)
rm -f "$DESKTOP_DIR/$FILE_NAME"
rm -f "$APPS_DIR/$FILE_NAME"
rm -f "$AUTOSTART_DIR/$FILE_NAME"
rm -f "/tmp/$FILE_NAME"
rm -f "/tmp/autostart-$FILE_NAME"

# 4. Create the standard .desktop file (Desktop + App Menu)
cat <<EOF > "/tmp/$FILE_NAME"
[Desktop Entry]
Version=1.0
Name=CachyOS Toolkit
Exec=/usr/bin/bash $SCRIPT_PATH
Icon=/home/$USER/.local/share/icons/cachyos-logo.svg
Terminal=false
Type=Application
Categories=Utility;System;
Comment=Manage your system with Justfile
StartupNotify=true
EOF

# 5. Create Autostart version with 5 second delay
cat <<EOF > "/tmp/autostart-$FILE_NAME"
[Desktop Entry]
Version=1.0
Name=CachyOS Toolkit
Exec=/usr/bin/sh -c "sleep 5 && /usr/bin/bash $SCRIPT_PATH"
Icon=/home/$USER/.local/share/icons/cachyos-logo.svg
Terminal=false
Type=Application
Categories=Utility;System;
Comment=Launch Toolkit at boot
StartupNotify=false
EOF

# 6. Force copy (overwrites without asking)
command cp -f "/tmp/$FILE_NAME" "$DESKTOP_DIR/$FILE_NAME"
command cp -f "/tmp/$FILE_NAME" "$APPS_DIR/$FILE_NAME"
command cp -f "/tmp/autostart-$FILE_NAME" "$AUTOSTART_DIR/$FILE_NAME"

# 7. Make executable
chmod +x "$DESKTOP_DIR/$FILE_NAME"
chmod +x "$APPS_DIR/$FILE_NAME"
chmod +x "$AUTOSTART_DIR/$FILE_NAME"
chmod +x "$SCRIPT_PATH"

echo "Installation complete!"
echo "Desktop icon, App Menu entry, and Autostart created (existing files overwritten)."
