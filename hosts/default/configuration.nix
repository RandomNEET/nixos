# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  lib,
  opts,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ../common.nix

    # ../../modules/bat
    # ../../modules/blueman
    # ../../modules/btop
    # ../../modules/cava
    # ../../modules/cron
    # ../../modules/docker
    # ../../modules/direnv
    # ../../modules/discord
    # ../../modules/disks
    # ../../modules/eza
    # ../../modules/fastfetch
    # ../../modules/firefox
    # ../../modules/firejail
    # ../../modules/flatpak
    # ../../modules/fonts
    # ../../modules/frp
    # ../../modules/fzf
    # ../../modules/games
    # ../../modules/garbage-collection
    # ../../modules/gimp
    # ../../modules/git
    # ../../modules/gpg
    # ../../modules/gpu/${opts.gpu}/${opts.hostType}
    # ../../modules/greetd
    # ../../modules/impermanence
    # ../../modules/jellyfin
    # ../../modules/jq
    # ../../modules/kitty
    # ../../modules/lazygit
    # ../../modules/libreoffice
    # ../../modules/libvirtd
    # ../../modules/localsend
    # ../../modules/mpv
    # ../../modules/nixvim
    # ../../modules/obs-studio
    # ../../modules/obsidian
    # ../../modules/pipewire
    # ../../modules/proxy/${opts.proxy.method}
    # ../../modules/rice
    # ../../modules/rigprep
    # ../../modules/samba
    # ../../modules/scripts/system/${opts.hostname}
    # ../../modules/scripts/user/${opts.hostname}
    # ../../modules/snapper
    # ../../modules/spicetify
    # ../../modules/spotify-player
    # ../../modules/ssh
    # ../../modules/swayimg
    # ../../modules/thunderbird
    # ../../modules/tmux
    # ../../modules/utilities
    # ../../modules/vscode
    # ../../modules/yazi
    # ../../modules/zathura
    # ../../modules/zoxide
    # ../../modules/zsh/${opts.hostType}

    # ../../modules/desktop/hyprland
    # ../../modules/desktop/themes/catppuccin
  ];

  # Define system packages here
  environment.systemPackages = with pkgs; [ ];

  # Home-manager config
  home-manager.sharedModules = [ (_: { home.packages = with pkgs; [ ]; }) ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
