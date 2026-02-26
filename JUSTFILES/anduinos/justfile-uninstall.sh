#!/usr/bin/env bash
set -euo pipefail

DESKTOP_DIR="$HOME/Desktop"
APPS_DIR="$HOME/.local/share/applications"
AUTOSTART_DIR="$HOME/.config/autostart"
FILE_NAME="Anduinos-Toolkit.desktop"

JUSTFILE_PATH="$HOME/justfile"
GUI_PATH="$HOME/justfile-gui.sh"
ICON_PATH="$HOME/.local/share/icons/anduinos-logo.svg"

echo "Uninstalling AnduinOS Toolkit files..."

rm -f "$JUSTFILE_PATH"
rm -f "$GUI_PATH"
rm -f "$ICON_PATH"

rm -f "$DESKTOP_DIR/$FILE_NAME"
rm -f "$APPS_DIR/$FILE_NAME"
rm -f "$AUTOSTART_DIR/$FILE_NAME"

echo "✔ Removed toolkit files, icon, and desktop entries."

echo
read -r -p "Also remove dependencies (just, yad)? (y/N): " remove_deps
if [[ "$remove_deps" =~ ^[yY]$ ]]; then
    sudo apt remove -y just yad || true
    sudo apt autoremove -y || true
    echo "✔ Dependencies removed (if installed)."
else
    echo "Skipped dependency removal."
fi

echo "Uninstall complete."
