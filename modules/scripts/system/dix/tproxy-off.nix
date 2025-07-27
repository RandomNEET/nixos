{ pkgs, ... }:
pkgs.writeShellScriptBin "tproxy-off" ''
  sudo ip route del local default dev lo table 100
  sudo ip rule del fwmark 1 table 100

  sudo iptables -t mangle -D PREROUTING -j XRAY
  sudo iptables -t mangle -D OUTPUT -j XRAY_SELF
  sudo iptables -t mangle -F XRAY
  sudo iptables -t mangle -F XRAY_SELF
  sudo iptables -t mangle -X XRAY
  sudo iptables -t mangle -X XRAY_SELF

  sudo systemctl stop xray.service
''
