#!/usr/bin/env bash
set -euo pipefail

export GTK_THEME=Adwaita:dark
cd "$HOME"

ICON_URL="https://raw.githubusercontent.com/Anduin2017/AnduinOS/47ef341b4ab9119905e3abcfd1949d718698ac14/src/mods/30-gnome-extension-arcmenu-patch/logo.svg"
ICON_PATH="/tmp/anduinos-logo.svg"

[ -f "$ICON_PATH" ] || curl -fsSL "$ICON_URL" -o "$ICON_PATH"

run_terminal() {
    x-terminal-emulator -e bash -c "just $1; echo; read -p 'Press Enter to close...'"
}

yad \
  --title="🚀 AnduinOS Toolkit" \
  --window-icon="$ICON_PATH" \
  --image="$ICON_PATH" \
  --image-on-top \
  --width=400 \
  --height=500 \
  --center \
  --text="\n<b>SYSTEM</b>" \
  --button="Update:0" \
  --button="Upgrade:1" \
  --button="Care:2" \
  --button="Factory Reset:3" \
  --text="\n<b>BOOTSTRAP</b>" \
  --button="Bootload Apps:4" \
  --button="Tune GNOME:5" \
  --text="\n<b>INFO</b>" \
  --button="Disk Report:6" \
  --button="Memory Report:7" \
  --button="CPU Report:8" \
  --text="\n<b>DESKFLOW & CLIPCASCADE</b>" \
  --button="Install Deskflow:9" \
  --button="Install ClipCascade:10" \
  --button="Restart ClipCascade:11" \
  --button="Status ClipCascade:12" \
  --text="\n<b>TOOLS</b>" \
  --button="Change Hostname:13" \
  --button="Refresh Justfile:14" \
  --button="Quit:99"

case $? in
  0)  run_terminal update ;;
  1)  run_terminal upgrade ;;
  2)  run_terminal care ;;
  3)  run_terminal factory-reset ;;
  4)  run_terminal bootload-apps ;;
  5)  run_terminal tune-gnome ;;
  6)  run_terminal report-disk ;;
  7)  run_terminal report-memory ;;
  8)  run_terminal report-cpu ;;
  9)  run_terminal install-df ;;
 10)  run_terminal install-cc ;;
 11)  run_terminal restart-cc ;;
 12)  run_terminal status-cc ;;
 13)  run_terminal change-hostname ;;
 14)  run_terminal refresh-justfile ;;
  *)  exit 0 ;;
esac
