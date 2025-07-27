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

    ../../modules/bash
    # ../../modules/bat
    # ../../modules/blueman
    # ../../modules/btop
    # ../../modules/cava
    ../../modules/cron
    ../../modules/docker
    # ../../modules/direnv
    # ../../modules/discord
    ../../modules/disks
    ../../modules/eza
    ../../modules/fastfetch
    # ../../modules/firefox
    # ../../modules/firejail
    # ../../modules/flatpak
    # ../../modules/fonts
    ../../modules/frp
    ../../modules/fzf
    # ../../modules/games
    ../../modules/garbage-collection
    # ../../modules/gimp
    ../../modules/git
    # ../../modules/gpg
    ../../modules/gpu/${opts.gpu}/${opts.role}
    # ../../modules/greetd
    # ../../modules/impermanence
    ../../modules/jellyfin
    # ../../modules/jq
    # ../../modules/kitty
    # ../../modules/lazygit
    # ../../modules/libreoffice
    # ../../modules/localsend
    # ../../modules/mpv
    ../../modules/nixvim
    # ../../modules/obs-studio
    # ../../modules/obsidian
    # ../../modules/pipewire
    ../../modules/proxy/${opts.proxy.method}
    ../../modules/rice
    # ../../modules/rigprep
    ../../modules/samba
    ../../modules/scripts/system/${opts.hostname}
    ../../modules/scripts/user/${opts.hostname}
    # ../../modules/snapper
    # ../../modules/spicetify
    # ../../modules/spotify-player
    ../../modules/ssh
    # ../../modules/swayimg
    # ../../modules/thunderbird
    ../../modules/tmux
    ../../modules/trash-cli
    # ../../modules/utilities
    ../../modules/virt-manager
    # ../../modules/vscode
    ../../modules/yazi
    # ../../modules/zathura
    ../../modules/zoxide
    ../../modules/zsh/${opts.role}

    # ../../modules/desktop/hyprland
    # ../../modules/desktop/themes/catppuccin
  ];

  # Define system packages here
  environment.systemPackages = with pkgs; [ iptables ];

  # Home-manager config
  home-manager.sharedModules = [ (_: { home.packages = with pkgs; [ ]; }) ];

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest; # _latest, _zen, _xanmod_latest, _hardened, _rt, _OTHER_CHANNEL, etc.

  fileSystems."/mnt/ssd" = {
    device = "/dev/disk/by-uuid/d850efcf-11d2-4a43-9a13-a61d362e1cd3";
    fsType = "ext4";
    options = [
      "defaults"
      "nofail"
    ];
    neededForBoot = false;
  };

  fileSystems."/mnt/smb" = {
    device = "/dev/disk/by-uuid/04CEA1884141A7D0";
    fsType = "ntfs-3g";
    options = [
      "uid=1000"
      "gid=100"
      "dmask=0002"
      "fmask=002"
      "exec"
    ];
    neededForBoot = false;
  };

  systemd.services.xray = {
    after = [
      "network.target"
      "docker.service"
    ];
  };

  systemd.services.jellyfin = {
    serviceConfig = {
      Environment = [
        "http_proxy=http://127.0.0.1:9998"
        "https_proxy=http://127.0.0.1:9998"
      ];
    };
  };

  systemd.services.docker = {
    serviceConfig = {
      Environment = [
        "http_proxy=http://127.0.0.1:9998"
        "https_proxy=http://127.0.0.1:9998"
      ];
    };
  };

  # Open ports in the firewall.
  networking.firewall.allowedTCPPorts = [
    5900
    6881
    7102
    9997
    9998
    9999
    10000
    10090
    10100
    10110
    10120
    10200
    10225
    10230
    10240
    10250
    10300
    10310
    10320
    10330
    10340
    10400
    10500
    61208
  ];
  networking.firewall.allowedUDPPorts = [ 6881 ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  nix.settings.require-sigs = false;
}
