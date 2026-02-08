#!/usr/bin/env bash

cd ~
git clone https://github.com/Sathvik-Rao/ClipCascade.git
cd ClipCascade
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt

#Start ClipCascade
cd $HOME/Downloads/ClipCascade && nohup python3 main.py &> /dev/null &