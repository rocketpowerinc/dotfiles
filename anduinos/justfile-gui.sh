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

    # Recipe Translation Layer
    case "$recipe" in
        "search")  recipe="apt-search" ;;
        "install") recipe="apt-install" ;;
        "remove")  recipe="apt-remove" ;;
    esac

    # Input dialog for specific tasks
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

# 3. GUI Definition
ARGS=(
  --title=""
  --window-icon="$ICON_PATH"
  --image="$ICON_PATH"
  --image-on-top
  --width=400
  --height=800
  --center
  --form
  --columns=1
  --scroll
  --text="<b><big>AnduinOS Toolkit</big></b>\n"

  --field="🧰 CONVENIENCE:LBL" ""
  --field="Refresh Justfile:BTN" "bash -c 'run_task refresh-justfile'"

  --field="\n⚙ SYSTEM:LBL" ""
  --field="Update:BTN" "bash -c 'run_task update'"
  --field="Upgrade:BTN" "bash -c 'run_task upgrade'"
  --field="Care:BTN" "bash -c 'run_task care'"
  --field="Factory Reset:BTN" "bash -c 'run_task factory-reset'"

  --field="\n📦 APT PACKAGES:LBL" ""
  --field="Search Package:BTN" "bash -c 'run_task search'"
  --field="Install Package:BTN" "bash -c 'run_task install'"
  --field="Remove Package:BTN" "bash -c 'run_task remove'"

  --field="\n🧊 FLATPAK PACKAGES:LBL" ""
  --field="Flatpak Search:BTN" "bash -c 'run_task flatpak-search'"
  --field="Flatpak List:BTN" "bash -c 'run_task flatpak-list'"
  --field="Flatpak Remotes:BTN" "bash -c 'run_task flatpak-remotes'"
  --field="Flatpak Remove Remote:BTN" "bash -c 'run_task flatpak-remove-remote'"

  --field="\n🚀 BOOTSTRAP:LBL" ""
  --field="Bootload Apps:BTN" "bash -c 'run_task bootload-apps'"
  --field="Tune GNOME:BTN" "bash -c 'run_task tune-gnome'"

  --field="\n📊 SYSTEM INFO:LBL" ""
  --field="Report Disk:BTN" "bash -c 'run_task report-disk'"
  --field="Report Memory:BTN" "bash -c 'run_task report-memory'"
  --field="Report CPU:BTN" "bash -c 'run_task report-cpu'"

  --field="\n🌐 EXTERNAL TOOLS:LBL" ""
  --field="TuxMate:BTN" "bash -c 'run_task tuxmate'"
  --field="Linux Toys:BTN" "bash -c 'run_task linux-toys'"
  --field="LinUtil:BTN" "bash -c 'run_task linutil'"

  --field="\n🔗 WEBSITES:LBL" ""
  --field="Packages Site:BTN" "bash -c 'run_task packages-site'"
  --field="Rocket Dashboard:BTN" "bash -c 'run_task rocket-dashboard'"

  # Fixed label below (replaced & with AND)
  --field="\n📎 DESKFLOW AND CLIPCASCADE:LBL" ""
  --field="Install Deskflow:BTN" "bash -c 'run_task install-df'"
  --field="Install ClipCascade:BTN" "bash -c 'run_task install-cc'"
  --field="Restart ClipCascade:BTN" "bash -c 'run_task restart-cc'"
  --field="Status ClipCascade:BTN" "bash -c 'run_task status-cc'"

  --field="\n🔨 TOOLS:LBL" ""
  --field="Change Hostname:BTN" "bash -c 'run_task change-hostname'"

  --button="Exit Toolkit:1"
)

yad "${ARGS[@]}"