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

# Start the Yad GUI
bash "$HOME/justfile-gui.sh"


echo "✔ justfile installed to $HOME/justfile"
