{ pkgs, ... }:
pkgs.writeShellScriptBin "backup" ''
  rsync -av --delete ~/nixos /mnt/ssd/backup/nixos
  rsync -av --delete /var/lib/jellyfin /mnt/ssd/backup/jellyfin/config
  rsync -av --delete /var/cache/jellyfin /mnt/ssd/backup/jellyfin/cache
  sudo rsync -av --delete ~/.docker /mnt/ssd/backup/docker
''
