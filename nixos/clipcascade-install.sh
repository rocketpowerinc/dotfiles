nix-shell -p python3 python3Packages.virtualenv wget unzip --run "
set -e

mkdir -p \$HOME/Downloads
cd \$HOME/Downloads

# Download latest Linux build zip
wget -O ClipCascade_Linux.zip https://github.com/Sathvik-Rao/ClipCascade/releases/latest/download/ClipCascade_Linux.zip

# Remove old folder if exists (clean install)
rm -rf ClipCascade

# Extract
unzip ClipCascade_Linux.zip

cd ClipCascade

# Create venv
python3 -m venv .venv
source .venv/bin/activate

pip install --upgrade pip
pip install -r requirements.txt

# Start ClipCascade
nohup python3 main.py > /dev/null 2>&1 &
"
