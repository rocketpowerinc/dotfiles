#!/usr/bin/env bash

mkdir -p ~/.config/systemd/user && \
cat << 'EOF' > ~/.config/systemd/user/clipcascade.service
[Unit]
Description=ClipCascade

[Service]
ExecStart=%h/ClipCascade/.venv/bin/python %h/ClipCascade/main.py
Restart=always

[Install]
WantedBy=default.target
EOF

systemctl --user daemon-reload && \
systemctl --user enable --now clipcascade.service