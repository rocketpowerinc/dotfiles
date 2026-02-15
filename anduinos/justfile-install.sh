#!/usr/bin/env bash
set -e


# Install Dependencies
sudo apt update && sudo apt install just

TMPDIR="$(mktemp -d)"
trap 'rm -rf "$TMPDIR"' EXIT

git clone --depth 1 https://github.com/rocketpowerinc/dotfiles.git "$TMPDIR"

install -m 644 \
  "$TMPDIR/anduinos/justfile" \
  "$HOME/justfile"

echo "✔ justfile installed to $HOME/justfile"
