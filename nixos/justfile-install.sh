#!/usr/bin/env bash


set -e

TMPDIR="$(mktemp -d)"
trap 'rm -rf "$TMPDIR"' EXIT

git clone --depth 1 https://github.com/rocketpowerinc/dotfiles.git "$TMPDIR"

install -m 644 \
  "$TMPDIR/nixos/justfile" \
  "$HOME/justfile"

echo "✔ justfile installed to $HOME/justfile"
