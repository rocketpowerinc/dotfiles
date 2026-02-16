#!/usr/bin/env bash
set -euo pipefail

export GTK_THEME=Adwaita:dark
export JUST_FILE="$HOME/justfile"
ICON_URL="https://raw.githubusercontent.com/Anduin2017/AnduinOS/47ef341b4ab9119905e3abcfd1949d718698ac14/src/mods/30-gnome-extension-arcmenu-patch/logo.svg"
ICON_PATH="/tmp/anduinos-logo.svg"

# 1. Terminal Detection
if command -v gnome-terminal >/dev/null 2>&1; then
    TERM_CMD="gnome-terminal --"
elif command -v kgx >/dev/null 2>&1; then
    TERM_CMD="kgx exec"
else
    TERM_CMD="x-terminal-emulator -e"
fi

# 2. Task Runner Function
run_task() {
    local recipe=$1
    local args=""

    case "$recipe" in
        "search")  recipe="apt-search" ;;
        "install") recipe="apt-install" ;;
        "remove")  recipe="apt-remove" ;;
    esac

    if [[ "$recipe" =~ ^(apt-search|apt-install|apt-remove|flatpak-search|flatpak-remove-remote)$ ]]; then
        args=$(yad --entry --title="Input Required" --text="Enter package name:" --width=300 --center)
        [[ -z "$args" ]] && return
    fi

    $TERM_CMD bash -c "just -f '$JUST_FILE' $recipe $args; echo; echo '-----------------------'; read -p 'Press any key to close...' -n1" &
}

export -f run_task
export TERM_CMD
export JUST_FILE

[ -f "$ICON_PATH" ] || curl -fsSL "$ICON_URL" -o "$ICON_PATH"

# 3. Styling Logic (Optimized for 400px width)
# We use a shorter separator (32 chars) to ensure no horizontal scroll triggers.
HEADER="<span color='#3498db' size='large'><b>"
FOOTER="</b></span>"
SEP="<span color='#444444'>────────────────────────────────</span>:LBL"

# 4. GUI Definition
ARGS=(
  --title="AnduinOS Toolkit"
  --window-icon="$ICON_PATH"
  --image="$ICON_PATH"
  --image-on-top
  --width=500
  --height=850
  --center
  --form
  --columns=1
  --scroll
  --text-align=center
  --text="<b><big>AnduinOS Toolkit</big></b>\n"

  --field="${HEADER}CONVENIENCE${FOOTER}:LBL" ""
  --field="Refresh Justfile:BTN" "bash -c 'run_task refresh-justfile'"
  --field="Refresh Justfile-GUI:BTN" "bash -c 'run_task refresh-justfile-gui'"
  --field="$SEP" ""

  --field="${HEADER}SYSTEM${FOOTER}:LBL" ""
  --field="Update:BTN" "bash -c 'run_task update'"
  --field="Upgrade:BTN" "bash -c 'run_task upgrade'"
  --field="Care:BTN" "bash -c 'run_task care'"
  --field="Factory Reset:BTN" "bash -c 'run_task factory-reset'"
  --field="$SEP" ""

  --field="${HEADER}APT PACKAGES${FOOTER}:LBL" ""
  --field="Search Package:BTN" "bash -c 'run_task search'"
  --field="Install Package:BTN" "bash -c 'run_task install'"
  --field="Remove Package:BTN" "bash -c 'run_task remove'"
  --field="$SEP" ""

  --field="${HEADER}FLATPAK PACKAGES${FOOTER}:LBL" ""
  --field="Flatpak Search:BTN" "bash -c 'run_task flatpak-search'"
  --field="Flatpak List:BTN" "bash -c 'run_task flatpak-list'"
  --field="Flatpak Remotes:BTN" "bash -c 'run_task flatpak-remotes'"
  --field="Flatpak Remove Remote:BTN" "bash -c 'run_task flatpak-remove-remote'"
  --field="$SEP" ""

  --field="${HEADER}BOOTSTRAP${FOOTER}:LBL" ""
  --field="Bootload Apps:BTN" "bash -c 'run_task bootload-apps'"
  --field="Tune Gnome:BTN" "bash -c 'run_task tune-gnome'"
  --field="Tune Nautilus:BTN" "bash -c 'run_task tune-nautilus'"
  --field="$SEP" ""

  --field="${HEADER}SYSTEM INFO${FOOTER}:LBL" ""
  --field="Report Disk:BTN" "bash -c 'run_task report-disk'"
  --field="Report Memory:BTN" "bash -c 'run_task report-memory'"
  --field="Report CPU:BTN" "bash -c 'run_task report-cpu'"
  --field="$SEP" ""

  --field="${HEADER}EXTERNAL TOOLS${FOOTER}:LBL" ""
  --field="TuxMate:BTN" "bash -c 'run_task tuxmate'"
  --field="Linux Toys:BTN" "bash -c 'run_task linux-toys'"
  --field="LinUtil:BTN" "bash -c 'run_task linutil'"
  --field="$SEP" ""

  --field="${HEADER}WEBSITES${FOOTER}:LBL" ""
  --field="Rocket Dashboard:BTN" "bash -c 'run_task rocket-dashboard'"
  --field="$SEP" ""

  --field="${HEADER}DESKFLOW &amp; CLIPCASCADE${FOOTER}:LBL" ""
  --field="Install Deskflow:BTN" "bash -c 'run_task install-df'"
  --field="Install ClipCascade:BTN" "bash -c 'run_task install-cc'"
  --field="Restart ClipCascade:BTN" "bash -c 'run_task restart-cc'"
  --field="Status ClipCascade:BTN" "bash -c 'run_task status-cc'"
  --field="$SEP" ""

  --field="${HEADER}TOOLS${FOOTER}:LBL" ""
  --field="Change Hostname:BTN" "bash -c 'run_task change-hostname'"

  --button="Exit Toolkit:1"
)

yad "${ARGS[@]}"