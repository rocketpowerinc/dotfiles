#!/usr/bin/env bash
set -euo pipefail

#! ==================================================
#! MASTER TEMPLATE CONFIG (edit this block only)
#! ==================================================
TOOLKIT_TITLE="AnduinOS Toolkit"
JUST_FILE="$HOME/justfile"
ICON_PATH="$HOME/.local/share/icons/anduinos-logo.svg"

#! ==================================================
#! ==================================================
#! ==================================================

export GTK_THEME=Adwaita:dark
export JUST_FILE

if command -v gnome-terminal >/dev/null 2>&1; then
    TERM_CMD="gnome-terminal --"
elif command -v kgx >/dev/null 2>&1; then
    TERM_CMD="kgx exec"
else
    TERM_CMD="x-terminal-emulator -e"
fi

run_task() {
    local recipe=$1
    local args=""

    case "$recipe" in
        "search")  recipe="pkg-search" ;;
        "install") recipe="pkg-install" ;;
        "remove")  recipe="pkg-remove" ;;
    esac

    if [[ "$recipe" =~ ^(pkg-search|pkg-install|pkg-remove|flatpak-search|flatpak-remove-remote)$ ]]; then
        args=$(yad --entry --title="Input Required" --text="Enter package name:" --width=300 --center)
        [[ -z "$args" ]] && return
    fi

    $TERM_CMD bash -c "just -f '$JUST_FILE' $recipe $args; echo; echo '-----------------------'; read -p 'Press any key to close...' -n1" &
}

export -f run_task
export TERM_CMD

HEADER="<span color='#3498db' size='large'><b>"
FOOTER="</b></span>"
SEP="<span color='#444444'>────────────────────────────────</span>:LBL"

ARGS=(
    --title="$TOOLKIT_TITLE"
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
    --text="<b><big>$TOOLKIT_TITLE</big></b>\n"

    --field="${HEADER}CONVENIENCE${FOOTER}:LBL" ""
    --field="Refresh Justfile:BTN" "bash -c 'run_task plj'"
    --field="Refresh Justfile-GUI:BTN" "bash -c 'run_task pljg'"
    --field="$SEP" ""

    --field="${HEADER}SYSTEM${FOOTER}:LBL" ""
    --field="Update:BTN" "bash -c 'run_task update'"
    --field="Upgrade:BTN" "bash -c 'run_task upgrade'"
    --field="Care:BTN" "bash -c 'run_task care'"
    --field="Factory Reset:BTN" "bash -c 'run_task factory-reset'"
    --field="$SEP" ""

    --field="${HEADER}PACKAGES${FOOTER}:LBL" ""
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

    --field="${HEADER}WALLPAPERS${FOOTER}:LBL" ""
    --field="Install Wallpaper Shuffle:BTN" "bash -c 'run_task install-wallpaper-shuffle'"
    --field="Start Wallpaper Shuffle:BTN" "bash -c 'run_task start-wallpaper-shuffle'"
    --field="Stop Wallpaper Shuffle:BTN" "bash -c 'run_task stop-wallpaper-shuffle'"
    --field="Status Wallpaper Shuffle:BTN" "bash -c 'run_task status-wallpaper-shuffle'"
    --field="Change Wallpaper Directory:BTN" "bash -c 'run_task change-wallpaper-folder'"
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

    --field="${HEADER}ROCKETPOWERINC${FOOTER}:LBL" ""
    --field="Rocket Dashboard:BTN" "bash -c 'run_task rocket-dashboard'"
    --field="Clone RocketPowerInc Repos:BTN" "bash -c 'run_task clone-rocketpowerinc'"
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
