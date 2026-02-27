# Arch Linux Toolkit

This folder is preconfigured for Arch Linux using `pacman`.

## Quick usage

1. Edit only the `MASTER TEMPLATE CONFIG` block at the top of each file if you want to customize values:
   - `justfile`
   - `justfile-gui.sh`
   - `justfile-install.sh`
   - `justfile-uninstall.sh`
2. Run installer from this folder.

## What to customize

- `DISTRO_NAME`: Display name in GUI and desktop launcher.
- `DISTRO_FOLDER`: Folder name under `JUSTFILES/` for `plj` / installer source path.
- `PKG_*_CMD`: Package manager commands (`apt`, `pacman`, `dnf`, etc.).
- `DISTRO_UPGRADE_CMD`, `DISTRO_REPAIR_CMD`: Distro-specific maintenance commands.
- `ICON_FILE_NAME` and `ICON_DEST_NAME`: Source icon and installed icon name.
- `DEPS_INSTALL_CMD`, `DEPS_REMOVE_CMD`: GUI dependency install/remove commands.

## Current pacman setup

In `justfile` config block:

- `PKG_LABEL := "PACMAN"`
- `PKG_UPDATE_CMD := "sudo pacman -Sy"`
- `PKG_UPGRADE_CMD := "sudo pacman -Syu --noconfirm"`
- `PKG_SEARCH_CMD := "pacman -Ss"`
- `PKG_INSTALL_CMD := "sudo pacman -S --noconfirm"`
- `PKG_REMOVE_CMD := "sudo pacman -Rns --noconfirm"`
- `PKG_AUTOREMOVE_CMD := "sudo pacman -Qdtq | sudo pacman -Rns - --noconfirm"`
- `PKG_AUTOCLEAN_CMD := "true"`

In install/uninstall scripts, dependencies are also set to pacman.

## Notes

- The template keeps the same command/menu structure as AnduinOS.
- Recipe names are package-manager neutral (`pkg-search`, `pkg-install`, `pkg-remove`).
- Keep your distro icon file inside the distro folder and set `ICON_FILE_NAME` accordingly.
