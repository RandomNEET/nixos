{ pkgs, ... }:
pkgs.writeShellScriptBin "smb-nasix-private" ''
  IP="192.168.0.56"

  if [ ! -d "/mnt/smb" ]; then
  	sudo mkdir /mnt/smb
  fi

  sudo mount -t cifs //"$IP"/private /mnt/smb -o username=$USER,uid=$(id -u),gid=$(id -g)
''
