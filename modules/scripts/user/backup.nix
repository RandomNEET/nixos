{ pkgs, opts, ... }:
if opts.hostname != null && opts.hostname == "dix" then
  pkgs.writeShellScriptBin "backup" ''
    cd ~/
    sudo tar czf vault.tar.gz ~/.vault
    gpg -e -r neet@randomneet.me vault.tar.gz && rm -f vault.tar.gz
    mv -v ~/vault.tar.gz.gpg /mnt/hdd2/backup

    rsync -av --delete ~/nixos /mnt/hdd2/backup
    rsync -av --delete ~/doc /mnt/hdd2/backup
    rsync -av --delete ~/pic /mnt/hdd2/backup
    rsync -av --delete ~/pkg /mnt/hdd2/backup
    rsync -av --delete ~/repo /mnt/hdd2/backup
  ''
else if opts.hostname != null && opts.hostname == "nasix" then
  pkgs.writeShellScriptBin "backup" ''
    rsync -av --delete ~/nixos /mnt/ssd/backup/nixos
    rsync -av --delete /var/lib/jellyfin /mnt/ssd/backup/jellyfin/config
    rsync -av --delete /var/cache/jellyfin /mnt/ssd/backup/jellyfin/cache
    sudo rsync -av --delete ~/.docker /mnt/ssd/backup/docker
  ''
else
  null
