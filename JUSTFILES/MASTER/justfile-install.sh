#!/usr/bin/env bash
set -euo pipefail

#! ==================================================
#! MASTER TEMPLATE CONFIG (edit this block only)
#! ==================================================
DISTRO_NAME="RocketOS"
DISTRO_FOLDER="MASTER"
REPO_URL="https://github.com/rocketpowerinc/dotfiles.git"
ICON_FILE_NAME="RocketOS.svg"
ICON_DEST_NAME="RocketOS.svg"
DEPS_INSTALL_CMD="sudo apt update && sudo apt install -y just yad"
DEPS_REMOVE_CMD="sudo apt remove -y just yad"

TOOLKIT_DESKTOP_FILE="${DISTRO_NAME// /}-Toolkit.desktop"
SCRIPT_PATH="$HOME/justfile-gui.sh"
ICON_DEST="$HOME/.local/share/icons/$ICON_DEST_NAME"

bash -lc "$DEPS_INSTALL_CMD"

TMPDIR="$(mktemp -d)"
trap 'rm -rf "$TMPDIR"' EXIT

git clone --depth 1 "$REPO_URL" "$TMPDIR"

JUSTFILES_DIR="$TMPDIR/JUSTFILES/$DISTRO_FOLDER"
if [[ ! -d "$JUSTFILES_DIR" ]]; then
    echo "Folder not found: JUSTFILES/$DISTRO_FOLDER"
    echo "Edit DISTRO_FOLDER in this script to match your repo folder name."
    exit 1
fi

install -m 777 "$JUSTFILES_DIR/justfile" "$HOME/justfile"
install -m 777 "$JUSTFILES_DIR/justfile-gui.sh" "$HOME/justfile-gui.sh"
chmod +x "$HOME/justfile-gui.sh"

mkdir -p "$HOME/.local/share/icons"
install -m 644 "$JUSTFILES_DIR/$ICON_FILE_NAME" "$ICON_DEST"

DESKTOP_DIR="$HOME/Desktop"
APPS_DIR="$HOME/.local/share/applications"
AUTOSTART_DIR="$HOME/.config/autostart"

mkdir -p "$DESKTOP_DIR" "$APPS_DIR" "$AUTOSTART_DIR"

rm -f "$DESKTOP_DIR/$TOOLKIT_DESKTOP_FILE"
rm -f "$APPS_DIR/$TOOLKIT_DESKTOP_FILE"
rm -f "$AUTOSTART_DIR/$TOOLKIT_DESKTOP_FILE"
rm -f "/tmp/$TOOLKIT_DESKTOP_FILE"
rm -f "/tmp/autostart-$TOOLKIT_DESKTOP_FILE"

cat <<EOF > "/tmp/$TOOLKIT_DESKTOP_FILE"
[Desktop Entry]
Version=1.0
Name=$DISTRO_NAME Toolkit
Exec=/usr/bin/bash $SCRIPT_PATH
Icon=$ICON_DEST
Terminal=false
Type=Application
Categories=Utility;System;
Comment=Manage your system with Justfile
StartupNotify=true
EOF

cat <<EOF > "/tmp/autostart-$TOOLKIT_DESKTOP_FILE"
[Desktop Entry]
Version=1.0
Name=$DISTRO_NAME Toolkit
Exec=/usr/bin/sh -c "sleep 5 && /usr/bin/bash $SCRIPT_PATH"
Icon=$ICON_DEST
Terminal=false
Type=Application
Categories=Utility;System;
Comment=Launch Toolkit at boot
StartupNotify=false
EOF

command cp -f "/tmp/$TOOLKIT_DESKTOP_FILE" "$DESKTOP_DIR/$TOOLKIT_DESKTOP_FILE"
command cp -f "/tmp/$TOOLKIT_DESKTOP_FILE" "$APPS_DIR/$TOOLKIT_DESKTOP_FILE"
command cp -f "/tmp/autostart-$TOOLKIT_DESKTOP_FILE" "$AUTOSTART_DIR/$TOOLKIT_DESKTOP_FILE"

chmod +x "$DESKTOP_DIR/$TOOLKIT_DESKTOP_FILE"
chmod +x "$APPS_DIR/$TOOLKIT_DESKTOP_FILE"
chmod +x "$AUTOSTART_DIR/$TOOLKIT_DESKTOP_FILE"
chmod +x "$SCRIPT_PATH"

echo "Installation complete!"
echo "Desktop icon, App Menu entry, and Autostart created."
echo "If needed later, uninstall deps with: $DEPS_REMOVE_CMD"
