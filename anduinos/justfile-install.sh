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


# Make a Desktop Icon
cat <<EOF > ~/Desktop/Anduinos-Toolkit.desktop
[Desktop Entry]
Version=1.0
Name=AnduinOS Toolkit
Exec=/usr/bin/bash /home/$USER/justfile-gui.sh
Icon=/home/$USER/.local/share/icons/anduinos-logo.svg
Terminal=false
Type=Application
Categories=Utility;System;
Comment=Manage your system with Justfile
StartupNotify=true
EOF

# SystemD At Boot
mkdir -p ~/.config/systemd/user

cat <<EOF > ~/.config/systemd/user/anduinos-toolkit.service
[Unit]
Description=AnduinOS Toolkit GUI
After=graphical-session.target network-online.target
Wants=network-online.target

[Service]
Type=simple
ExecStartPre=/usr/bin/bash -c 'until ping -c1 github.com >/dev/null 2>&1; do sleep 2; done'
ExecStart=%h/justfile-gui.sh

[Install]
WantedBy=default.target
EOF

systemctl --user daemon-reload
systemctl --user enable anduinos-toolkit.service




echo "✔ justfile + gui + desktop icon + systemd job have been installed"
