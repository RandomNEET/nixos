{ pkgs, ... }:
pkgs.writeShellScriptBin "backup" ''
  tar czf vault.tar.gz ~/.vault
  gpg -e -r neet@randomneet.me vault.tar.gz && rm vault.tar.gz
  mv -v ~/vault.tar.gz.gpg /mnt/hdd2/backup

  rsync -av --delete ~/nixos /mnt/hdd2/backup
  rsync -av --delete ~/doc /mnt/hdd2/backup
  rsync -av --delete ~/pic /mnt/hdd2/backup
  rsync -av --delete ~/pkg /mnt/hdd2/backup
  rsync -av --delete ~/repo /mnt/hdd2/backup
''
