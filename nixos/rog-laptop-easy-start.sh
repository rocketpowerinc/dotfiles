set -e

TMPDIR="$(mktemp -d)"

git clone --depth 1 https://github.com/rocketpowerinc/dotfiles.git "$TMPDIR"

sudo install -m 644 \
  "$TMPDIR/nixos/rog-laptop.nix" \
  /etc/nixos/configuration.nix

rm -rf "$TMPDIR"

sudo nixos-rebuild switch
