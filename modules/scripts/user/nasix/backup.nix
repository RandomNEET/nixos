{ pkgs, ... }:
pkgs.writeShellScriptBin "backup" ''
  rsync -avz --delete ~/nixos /mnt/smb/backup/nixos
  rsync -avz --delete /var/lib/jellyfin /mnt/smb/backup/jellyfin/config
  rsync -avz --delete /var/cache/jellyfin /mnt/smb/backup/jellyfin/cache
  sudo rsync -avz --delete ~/.docker /mnt/smb/backup/docker
''
