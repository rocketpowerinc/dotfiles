#!/usr/bin/env bash

cd ~
git clone https://github.com/Sathvik-Rao/ClipCascade.git
cd ClipCascade
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt