{ pkgs, ... }:
pkgs.writeShellScriptBin "rsync-nixos" ''
  set -e  # Exit immediately if any command fails

  REMOTE_HOST="dix"
  REMOTE_PATH="/home/howl/nixos"
  LOCAL_PATH="$HOME"
  WHOAMI_NIX="$LOCAL_PATH/nixos/hosts/whoami.nix"

  # Check if the remote host is reachable via SSH
  if ssh -q -o ConnectTimeout=3 "$REMOTE_HOST" exit; then
      echo "[✓] $REMOTE_HOST is online. Starting synchronization..."

      # Sync the NixOS configuration from remote to local
      rsync -az --delete --exclude='.git/' "$REMOTE_HOST:$REMOTE_PATH" "$LOCAL_PATH/"

      # Replace the host field in whoami.nix with the current machine's hostname
      sed -i "s/host = \".*\"/host = \"$(hostname)\"/" "$WHOAMI_NIX"

      echo "[✓] Synchronization complete. Host field updated to $(hostname)."
  else
      echo "[×] Cannot connect to $REMOTE_HOST. Synchronization skipped."
  fi
''
