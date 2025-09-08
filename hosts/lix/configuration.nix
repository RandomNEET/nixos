# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  lib,
  pkgs,
  opts,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../common.nix

    ../../modules/bash
    ../../modules/bat
    ../../modules/blueman
    ../../modules/btop
    ../../modules/cava
    # ../../modules/cron
    # ../../modules/docker
    ../../modules/direnv
    ../../modules/discord
    ../../modules/disks
    ../../modules/eza
    ../../modules/fastfetch
    ../../modules/firefox
    ../../modules/firejail
    ../../modules/flatpak
    ../../modules/fonts
    # ../../modules/frp
    ../../modules/fzf
    ../../modules/games
    ../../modules/garbage-collection
    ../../modules/gh
    # ../../modules/gimp
    ../../modules/git
    ../../modules/gpg
    ../../modules/gpu
    ../../modules/greetd
    ../../modules/impermanence
    # ../../modules/jellyfin
    ../../modules/jq
    ../../modules/kitty
    ../../modules/lazygit
    ../../modules/libreoffice
    ../../modules/localsend
    ../../modules/mpv
    ../../modules/nixvim
    ../../modules/obs-studio
    ../../modules/obsidian
    ../../modules/pipewire
    ../../modules/proxy
    ../../modules/rice
    ../../modules/rigprep
    # ../../modules/samba
    ../../modules/scripts
    ../../modules/secure-boot
    ../../modules/snapper
    ../../modules/spicetify
    ../../modules/spotify-player
    ../../modules/ssh
    ../../modules/swayimg
    ../../modules/thunderbird
    ../../modules/tmux
    ../../modules/trash-cli
    ../../modules/utilities
    ../../modules/virtualisation
    ../../modules/vscode
    ../../modules/yazi
    ../../modules/zathura
    ../../modules/zoxide
    ../../modules/zsh

    ../../modules/desktop/hyprland
    ../../modules/desktop/themes/catppuccin
  ];

  # Define system packages here
  environment.systemPackages = with pkgs; [ ];

  # Home-manager config
  home-manager.sharedModules = [
    (_: {
      home.packages = with pkgs; [ ];
    })
  ];

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_zen; # _latest, _zen, _xanmod_latest, _hardened, _rt, _OTHER_CHANNEL, etc

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
