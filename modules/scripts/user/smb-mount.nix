{ pkgs, opts, ... }:
if opts.hostname != null && (opts.hostname == "dix" || opts.hostname == "lix") then
  pkgs.writeShellScriptBin "smb-mount" ''
    IP="192.168.0.56"

    if [ ! -d "/mnt/smb" ]; then
    	sudo mkdir -p /mnt/smb
    fi

    sudo mount -t cifs //"$IP"/private /mnt/smb -o username=$USER,uid=$(id -u),gid=$(id -g)
  ''
else
  null
