{ pkgs, isExt, ... }:
let
  isExtEnv = if isExt then "true" else "false";
in
pkgs.writeShellScriptBin "oix-init" ''
  set -e

  REPO_URL="https://github.com/RandomNEET/oix"
  TARGET_PATH="$HOME/oix"
  BACKUP_SUFFIX=".bak.$(date +%Y%m%d_%H%M%S)"

  if [ ! -d "$TARGET_PATH" ]; then
    echo "Initializing Moving Castle, cloning repository..."
    ${pkgs.git}/bin/git clone "$REPO_URL" "$TARGET_PATH"
  else
    echo "Core directory already exists: $TARGET_PATH"
  fi

  if [ "${isExtEnv}" = "true" ]; then
    DEST="$HOME/.config/home-manager"
    SUDO=""
  else
    if [ -d "/nix/persist" ]; then
      DEST="/nix/persist/etc/nixos"
    else
      DEST="/etc/nixos"
    fi
    SUDO="sudo"
  fi

  if [ -d "$DEST" ]; then
    REAL_FILES=$($SUDO find "$DEST" -maxdepth 1 -mindepth 1 ! -type l | wc -l)

    if [ "$REAL_FILES" -gt 0 ]; then
      echo "Real files detected in $DEST. Creating backup..."
      $SUDO mv "$DEST" "$DEST$BACKUP_SUFFIX"
      echo "Backup saved to $DEST$BACKUP_SUFFIX"
    else
      echo "$DEST contains only symlinks (or is empty). Skipping backup."
      $SUDO rm -rf "$DEST"
    fi
  fi

  echo "Creating symlinks to $DEST"
  $SUDO mkdir -p "$DEST"
  $SUDO ln -sfn "$TARGET_PATH"/* "$DEST/"

  echo "Initialization complete!"
''
