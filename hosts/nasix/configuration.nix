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
    # ../../modules/system/blueman
    ../../modules/system/cron
    ../../modules/system/docker
    # ../../modules/system/flatpak
    ../../modules/system/frp
    ../../modules/system/garbage-collect
    ../../modules/system/gpu
    # ../../modules/system/impermanence
    ../../modules/system/jellyfin
    # ../../modules/system/pipewire
    ../../modules/system/proxy
    ../../modules/system/samba
    # ../../modules/system/secure-boot
    # ../../modules/system/snapper
    ../../modules/system/ssh
    ../../modules/system/virtualisation

    # ../../modules/desktop/fonts
    # ../../modules/desktop/greetd
    # ../../modules/desktop/hyprland
    # ../../modules/desktop/themes/catppuccin

    ../../modules/cli/bash
    ../../modules/cli/bat
    ../../modules/cli/btop
    # ../../modules/cli/cava
    ../../modules/cli/direnv
    ../../modules/cli/eza
    ../../modules/cli/fastfetch
    ../../modules/cli/fzf
    # ../../modules/cli/gh
    ../../modules/cli/git
    # ../../modules/cli/gpg
    ../../modules/cli/jq
    ../../modules/cli/lazygit
    ../../modules/cli/mpv
    ../../modules/cli/nixvim
    ../../modules/cli/rigprep
    # ../../modules/cli/spotify-player
    ../../modules/cli/tmux
    ../../modules/cli/trash-cli
    ../../modules/cli/yazi
    ../../modules/cli/zoxide
    ../../modules/cli/zsh

    # ../../modules/gui/discord
    # ../../modules/gui/fcitx5
    # ../../modules/gui/firefox
    # ../../modules/gui/firejail
    # ../../modules/gui/games
    # ../../modules/gui/gimp
    # ../../modules/gui/kitty
    # ../../modules/gui/libreoffice
    # ../../modules/gui/localsend
    # ../../modules/gui/obs-studio
    # ../../modules/gui/obsidian
    # ../../modules/gui/spicetify
    # ../../modules/gui/swayimg
    # ../../modules/gui/thunderbird
    # ../../modules/gui/vscode
    # ../../modules/gui/zathura

    ../../modules/no-config/archive
    # ../../modules/no-config/media
    ../../modules/no-config/rice
    # ../../modules/no-config/type

    ../../modules/scripts
  ];

  # Define system packages here
  environment.systemPackages = with pkgs; [ iptables ];

  # Home-manager config
  home-manager.sharedModules = [ (_: { home.packages = with pkgs; [ ]; }) ];

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages; # _latest, _zen, _xanmod_latest, _hardened, _rt, _OTHER_CHANNEL, etc.

  # Disks
  fileSystems."/mnt/ssd" = {
    device = "/dev/disk/by-uuid/d850efcf-11d2-4a43-9a13-a61d362e1cd3";
    fsType = "ext4";
    options = [
      "defaults"
      "nofail"
      "X-mount.mkdir"
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
      "nofail"
      "X-mount.mkdir"
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
