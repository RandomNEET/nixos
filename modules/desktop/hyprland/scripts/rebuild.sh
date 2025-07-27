#!/usr/bin/env bash

# Get hostname from /etc/hostname
HOSTNAME=$(cat /etc/hostname)

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

if [[ $EUID -eq 0 ]]; then
  echo "This script should not be executed as root! Exiting..."
  exit 1
fi

if [[ ! "$(grep -i nixos </etc/os-release)" ]]; then
  echo "This installation script only works on NixOS! Download an iso at https://nixos.org/download/"
  echo "Keep in mind that this script is not intended for use while in the live environment."
  exit 1
fi

if [ -f "$HOME/nixos/flake.nix" ]; then
  flake=$HOME/nixos
elif [ -f "/etc/nixos/flake.nix" ]; then
  flake=/etc/nixos
else
  echo "Error: flake not found. ensure flake.nix exists in either $HOME/nixos or /etc/nixos"
  exit 1
fi
echo -e "${GREEN}Rebuilding from $flake${NC}"
currentUser=$(logname)

# replace username variable in flake.nix with $USER
sudo sed -i -e "s/username = \".*\"/username = \"$currentUser\"/" "$flake/flake.nix"

if [ -f "/etc/nixos/hardware-configuration.nix" ]; then
  cat "/etc/nixos/hardware-configuration.nix" | sudo tee "$flake/hosts/$HOSTNAME/hardware-configuration.nix" >/dev/null
elif [ -f "/etc/nixos/hosts/$HOSTNAME/hardware-configuration.nix" ]; then
  cat "/etc/nixos/hosts/$HOSTNAME/hardware-configuration.nix" | sudo tee "$flake/hosts/$HOSTNAME/hardware-configuration.nix" >/dev/null
else
  # read -p "No hardware config found, generate another? (Y/n): " confirm
  # if [[ "$confirm" =~ ^[nN]$ ]]; then
  #   echo "Aborted."
  #   exit 1
  # fi
  sudo nixos-generate-config --show-hardware-config >"$flake/hosts/$HOSTNAME/hardware-configuration.nix"
fi

sudo git -C "$flake" add hosts/$HOSTNAME/hardware-configuration.nix

# nh os switch "$flake"
sudo nixos-rebuild switch --flake "$flake#$HOSTNAME"
# rm "$flake"/hosts/Default/hardware-configuration.nix &>/dev/null
# git restore --staged "$flake"/hosts/Default/hardware-configuration.nix &>/dev/null

echo
read -rsn1 -p"$(echo -e "${GREEN}Press any key to continue${NC}")"
