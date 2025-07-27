{ pkgs, ... }:
pkgs.writeShellScriptBin "backup" ''
  tar czf vault.tar.gz ~/.vault
  gpg -e -r 349FEC12317B400EE0570F6648D4C0CF3B64D33F vault.tar.gz && rm vault.tar.gz
  mv -v ~/vault.tar.gz.gpg /mnt/hdd2/backup

  rsync -av --delete ~/nixos /mnt/hdd2/backup
  rsync -av --delete ~/doc /mnt/hdd2/backup
  rsync -av --delete ~/pic /mnt/hdd2/backup
  rsync -av --delete ~/pkg /mnt/hdd2/backup
  rsync -av --delete ~/repo /mnt/hdd2/backup
''
