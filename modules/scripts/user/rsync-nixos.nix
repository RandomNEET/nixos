{ pkgs, opts, ... }:
if opts.hostname != null && opts.hostname == "nasix" then
  pkgs.writeShellScriptBin "rsync-nixos" ''
    set -e  # Exit immediately if any command fails

    REMOTE_HOST="dix"
    REMOTE_PATH="/home/howl/nixos"
    LOCAL_PATH="$HOME"

    # Check if the remote host is reachable via SSH
    if ssh -q -o ConnectTimeout=3 "$REMOTE_HOST" exit; then
        echo "[✓] $REMOTE_HOST is online. Starting synchronization..."

        # Sync the NixOS configuration from remote to local
        rsync -az --delete --exclude='.git/' "$REMOTE_HOST:$REMOTE_PATH" "$LOCAL_PATH/"

        echo "[✓] Synchronization complete. Host field updated to $(hostname)."
    else
        echo "[×] Cannot connect to $REMOTE_HOST. Synchronization skipped."
    fi
  ''
else
  null
