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
    if [[ "$recipe" == "apt-search" || "$recipe" == "apt-install" || "$recipe" == "apt-remove" || "$recipe" == "flatpak-search" || "$recipe" == "flatpak-remove-remote" ]]; then
        args=$(yad --entry --title="Input Required" --text="Enter name:" --width=300 --center)
        [[ -z "$args" ]] && return
    fi
    $TERM_CMD bash -c "just -f '$JUST_FILE' $recipe $args; echo; echo '-----------------------'; read -p 'Press any key to close...' -n1" &
}

export -f run_task
export TERM_CMD
export JUST_FILE

[ -f "$ICON_PATH" ] || curl -fsSL "$ICON_URL" -o "$ICON_PATH"

# 3. The GUI - Using Vertical Frames to prevent grid drift
yad --title="🚀 AnduinOS Toolkit" \
    --window-icon="$ICON_PATH" \
    --image="$ICON_PATH" \
    --image-on-top \
    --width=850 --height=700 --center \
    --form --columns=1 --scroll \
    --text="<b><big>AnduinOS Management Center</big></b>\n" \
    \
    --field="⚙️ SYSTEM:LBL" "" \
    --field="":FBTN "bash -c 'true'" \
    --field="Update System:BTN" "bash -c 'run_task update'" \
    --field="Upgrade OS:BTN" "bash -c 'run_task upgrade'" \
    --field="System Care:BTN" "bash -c 'run_task care'" \
    --field="Factory Reset:BTN" "bash -c 'run_task factory-reset'" \
    --field="Refresh Justfile:BTN" "bash -c 'run_task refresh-justfile'" \
    --field="Change Hostname:BTN" "bash -c 'run_task change-hostname'" \
    \
    --field="\n📦 PACKAGES:LBL" "" \
    --field="":FBTN "bash -c 'true'" \
    --field="APT Search:BTN" "bash -c 'run_task apt-search'" \
    --field="APT Install:BTN" "bash -c 'run_task apt-install'" \
    --field="APT Remove:BTN" "bash -c 'run_task apt-remove'" \
    --field="Flatpak Search:BTN" "bash -c 'run_task flatpak-search'" \
    --field="Flatpak List:BTN" "bash -c 'run_task flatpak-list'" \
    --field="Flatpak Remotes:BTN" "bash -c 'run_task flatpak-remotes'" \
    \
    --field="\n🚀 BOOTSTRAP & TOOLS:LBL" "" \
    --field="":FBTN "bash -c 'true'" \
    --field="Bootload Apps:BTN" "bash -c 'run_task bootload-apps'" \
    --field="Tune GNOME:BTN" "bash -c 'run_task tune-gnome'" \
    --field="LinUtil:BTN" "bash -c 'run_task linutil'" \
    --field="Linux Toys:BTN" "bash -c 'run_task linux-toys'" \
    --field="TuxMate:BTN" "bash -c 'run_task tuxmate'" \
    --field="Packages Site:BTN" "bash -c 'run_task packages-site'" \
    \
    --field="\n📊 INFO & SERVICES:LBL" "" \
    --field="":FBTN "bash -c 'true'" \
    --field="Disk Report:BTN" "bash -c 'run_task report-disk'" \
    --field="Memory Report:BTN" "bash -c 'run_task report-memory'" \
    --field="CPU Report:BTN" "bash -c 'run_task report-cpu'" \
    --field="Install Deskflow:BTN" "bash -c 'run_task install-df'" \
    --field="Install ClipCascade:BTN" "bash -c 'run_task install-cc'" \
    --field="Restart ClipCascade:BTN" "bash -c 'run_task restart-cc'" \
    --field="Status ClipCascade:BTN" "bash -c 'run_task status-cc'" \
    --field="Rocket Dashboard:BTN" "bash -c 'run_task rocket-dashboard'" \
    --field="Remove Remote:BTN" "bash -c 'run_task flatpak-remove-remote'" \
    \
    --button="Exit Toolkit:1"