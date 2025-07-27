{ pkgs, ... }:
pkgs.writeShellScriptBin "backup" ''
  rsync -avz --delete ~/nixos /mnt/hdd2/backup
  rsync -avz --delete ~/.vault /mnt/hdd2/backup
  rsync -avz --delete ~/doc /mnt/hdd2/backup
  rsync -avz --delete ~/pic /mnt/hdd2/backup
  rsync -avz --delete ~/pkg /mnt/hdd2/backup
  rsync -avz --delete ~/repo /mnt/hdd2/backup
''
