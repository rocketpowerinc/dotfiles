#!/usr/bin/env bash
set -euo pipefail

cleanup() {
    echo -e "\n\n!!! CRASH DETECTED !!!"
    echo "Check the error message above."
    read -p "Press enter to exit..."
}
trap cleanup ERR

echo "==> ClipCascade NixOS installer starting..."

# Requirements for the installer environment
nix-shell -p \
  python3 \
  python3Packages.virtualenv \
  python3Packages.pip \
  wget \
  unzip \
  --run "$(cat << 'EOF'
set -e

APP_DIR="$HOME/.local/share/ClipCascade"
SYSTEMD_DIR="$HOME/.config/systemd/user"
ZIP_FILE="/tmp/ClipCascade_Linux.zip"

mkdir -p "$APP_DIR" "$SYSTEMD_DIR"

echo "==> Downloading latest release..."
wget -q --show-progress -O "$ZIP_FILE" "https://github.com/Sathvik-Rao/ClipCascade/releases/latest/download/ClipCascade_Linux.zip"

echo "==> Extracting files..."
unzip -q -o "$ZIP_FILE" -d "$APP_DIR"

# Find the actual code directory (handles nested folders in ZIP)
REQ_PATH=$(find "$APP_DIR" -name "requirements.txt" -print -quit)
if [ -z "$REQ_PATH" ]; then
    echo "Error: Could not find requirements.txt!"
    exit 1
fi

REAL_ROOT=$(dirname "$REQ_PATH")
cd "$REAL_ROOT"

echo "==> Setting up Python Virtualenv..."
python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt

echo "==> Creating NixOS-compatible systemd service..."

# Create a wrapper script that loads the Nix environment
WRAPPER_SCRIPT="$REAL_ROOT/start-clipcascade.sh"
cat > "$WRAPPER_SCRIPT" <<'WRAPPER_EOF'
#!/usr/bin/env bash
# Wrapper script to run ClipCascade with proper Nix dependencies

# Activate virtual environment
source "$(dirname "$0")/.venv/bin/activate"

# Run with nix-shell to ensure GUI libraries are available
exec nix-shell -p \
  python3 \
  xorg.libX11 \
  xorg.libXcursor \
  xorg.libXrandr \
  xorg.libXinerama \
  xorg.libXi \
  xorg.libXfixes \
  wayland \
  libxkbcommon \
  --run "python $(dirname "$0")/main.py"
WRAPPER_EOF

chmod +x "$WRAPPER_SCRIPT"

# Create systemd service that uses the wrapper
cat > "$SYSTEMD_DIR/clipcascade.service" <<INNER_EOF
[Unit]
Description=ClipCascade Clipboard Sync
After=graphical-session.target

[Service]
Type=simple
WorkingDirectory=$REAL_ROOT
ExecStart=$WRAPPER_SCRIPT
Restart=always
RestartSec=5
Environment="PATH=/run/current-system/sw/bin:/etc/profiles/per-user/%u/bin:$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin"

[Install]
WantedBy=default.target
INNER_EOF

echo "==> Activating service..."
systemctl --user daemon-reload
systemctl --user enable clipcascade.service
systemctl --user start clipcascade.service

echo "------------------------------------------------"
echo "==> SUCCESS!"
echo "ClipCascade is now running as a background user service."
echo ""
echo "Useful commands:"
echo "  View logs:    journalctl --user -u clipcascade -f"
echo "  Stop service: systemctl --user stop clipcascade"
echo "  Start service: systemctl --user start clipcascade"
echo "  Check status: systemctl --user status clipcascade"
echo "------------------------------------------------"
EOF
)"