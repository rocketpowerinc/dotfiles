#!/usr/bin/env bash
set -euo pipefail

#! ==================================================
#! MASTER TEMPLATE CONFIG (edit this block only)
#! ==================================================
DISTRO_NAME="AnduinOS"
ICON_DEST_NAME="anduinos-logo.svg"
DEPS_REMOVE_CMD="sudo apt remove -y just yad"

TOOLKIT_DESKTOP_FILE="${DISTRO_NAME// /}-Toolkit.desktop"

DESKTOP_DIR="$HOME/Desktop"
APPS_DIR="$HOME/.local/share/applications"
AUTOSTART_DIR="$HOME/.config/autostart"

JUSTFILE_PATH="$HOME/justfile"
GUI_PATH="$HOME/justfile-gui.sh"
ICON_PATH="$HOME/.local/share/icons/$ICON_DEST_NAME"

echo "Uninstalling $DISTRO_NAME Toolkit files..."

rm -f "$JUSTFILE_PATH"
rm -f "$GUI_PATH"
rm -f "$ICON_PATH"
rm -f "$DESKTOP_DIR/$TOOLKIT_DESKTOP_FILE"
rm -f "$APPS_DIR/$TOOLKIT_DESKTOP_FILE"
rm -f "$AUTOSTART_DIR/$TOOLKIT_DESKTOP_FILE"

echo "✔ Removed toolkit files, icon, and desktop entries."

echo
read -r -p "Also remove dependencies using '$DEPS_REMOVE_CMD'? (y/N): " remove_deps
if [[ "$remove_deps" =~ ^[yY]$ ]]; then
    bash -lc "$DEPS_REMOVE_CMD" || true
    sudo apt autoremove -y || true
    echo "✔ Dependencies removed (if installed)."
else
    echo "Skipped dependency removal."
fi

echo "Uninstall complete."
