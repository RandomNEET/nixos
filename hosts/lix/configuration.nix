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
    ./hardware-configuration.nix
    ../common.nix

    ../../modules/system/automount
    ../../modules/system/blueman
    # ../../modules/system/cron
    # ../../modules/system/docker
    ../../modules/system/flatpak
    # ../../modules/system/frp
    ../../modules/system/garbage-collect
    ../../modules/system/gpu
    ../../modules/system/impermanence
    # ../../modules/system/jellyfin
    ../../modules/system/pipewire
    ../../modules/system/proxy
    # ../../modules/system/samba
    ../../modules/system/secure-boot
    ../../modules/system/snapper
    ../../modules/system/ssh
    ../../modules/system/virtualisation

    ../../modules/desktop/fonts
    ../../modules/desktop/greetd
    ../../modules/desktop/hyprland
    ../../modules/desktop/themes/catppuccin

    ../../modules/cli/bash
    ../../modules/cli/bat
    ../../modules/cli/btop
    ../../modules/cli/cava
    ../../modules/cli/direnv
    ../../modules/cli/eza
    ../../modules/cli/fastfetch
    ../../modules/cli/fzf
    ../../modules/cli/gh
    ../../modules/cli/git
    ../../modules/cli/gpg
    ../../modules/cli/jq
    ../../modules/cli/lazygit
    ../../modules/cli/mpv
    ../../modules/cli/nixvim
    ../../modules/cli/rigprep
    ../../modules/cli/spotify-player
    ../../modules/cli/tmux
    ../../modules/cli/trash-cli
    ../../modules/cli/yazi
    ../../modules/cli/zoxide
    ../../modules/cli/zsh

    ../../modules/gui/discord
    ../../modules/gui/fcitx5
    ../../modules/gui/firefox
    ../../modules/gui/firejail
    ../../modules/gui/games
    # ../../modules/gui/gimp
    ../../modules/gui/kitty
    ../../modules/gui/libreoffice
    ../../modules/gui/localsend
    ../../modules/gui/obs-studio
    ../../modules/gui/obsidian
    ../../modules/gui/spicetify
    ../../modules/gui/swayimg
    ../../modules/gui/thunderbird
    ../../modules/gui/vscode
    ../../modules/gui/zathura

    ../../modules/no-config/archive
    ../../modules/no-config/media
    ../../modules/no-config/rice
    ../../modules/no-config/type

    ../../modules/scripts
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
  boot.kernelPackages = pkgs.linuxPackages_zen; # _latest, _zen, _xanmod_latest, _hardened, _rt, _OTHER_CHANNEL, etc.

  # Battery charging threshold
  services.tlp = {
    enable = true;
    settings = {
      START_CHARGE_THRESH_BAT0 = 40;
      STOP_CHARGE_THRESH_BAT0 = 80;
      START_CHARGE_THRESH_BAT1 = 40;
      STOP_CHARGE_THRESH_BAT1 = 80;
    };
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
