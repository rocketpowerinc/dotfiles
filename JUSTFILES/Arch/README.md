# MASTER Toolkit Template

This folder is a reusable starter for creating distro-specific toolkits (e.g. `ArchOS`, `DebianOS`, etc.) without rewriting structure.

## Quick workflow

1. Copy this folder:
   - `cp -r JUSTFILES/MASTER JUSTFILES/<YourDistroFolder>`
2. Rename icon file if desired, and update script variables.
3. Edit only the `MASTER TEMPLATE CONFIG` block at the top of each file:
   - `justfile`
   - `justfile-gui.sh`
   - `justfile-install.sh`
   - `justfile-uninstall.sh`
4. Run installer from the new folder.

## What to customize

- `DISTRO_NAME`: Display name in GUI and desktop launcher.
- `DISTRO_FOLDER`: Folder name under `JUSTFILES/` for `plj` / installer source path.
- `PKG_*_CMD`: Package manager commands (`apt`, `pacman`, `dnf`, etc.).
- `DISTRO_UPGRADE_CMD`, `DISTRO_REPAIR_CMD`: Distro-specific maintenance commands.
- `ICON_FILE_NAME` and `ICON_DEST_NAME`: Source icon and installed icon name.
- `DEPS_INSTALL_CMD`, `DEPS_REMOVE_CMD`: GUI dependency install/remove commands.

## Example: Arch-based setup

In `justfile` config block:

- `PKG_LABEL := "PACMAN"`
- `PKG_UPDATE_CMD := "sudo pacman -Sy"`
- `PKG_UPGRADE_CMD := "sudo pacman -Syu --noconfirm"`
- `PKG_SEARCH_CMD := "pacman -Ss"`
- `PKG_INSTALL_CMD := "sudo pacman -S --noconfirm"`
- `PKG_REMOVE_CMD := "sudo pacman -Rns --noconfirm"`
- `PKG_AUTOREMOVE_CMD := "sudo pacman -Qdtq | sudo pacman -Rns - --noconfirm"`
- `PKG_AUTOCLEAN_CMD := "true"`

In install/uninstall scripts:

- Switch dependency commands to your distro package manager.

## Notes

- The template keeps the same command/menu structure as AnduinOS.
- Recipe names are package-manager neutral (`pkg-search`, `pkg-install`, `pkg-remove`).
- Keep your distro icon file inside the distro folder and set `ICON_FILE_NAME` accordingly.
