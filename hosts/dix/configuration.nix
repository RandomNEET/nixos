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

    ../../modules/system/fonts
    ../../modules/system/garbage-collect
    ../../modules/system/gpu
    ../../modules/system/impermanence
    ../../modules/system/secure-boot
    ../../modules/system/virtualisation

    ../../modules/services/automount
    ../../modules/services/blueman
    ../../modules/services/flatpak
    ../../modules/services/greetd
    ../../modules/services/mpd
    ../../modules/services/pipewire
    ../../modules/services/proxy
    ../../modules/services/snapper
    ../../modules/services/ssh

    ../../modules/programs/cli/bash
    ../../modules/programs/cli/bat
    ../../modules/programs/cli/btop
    ../../modules/programs/cli/cava
    ../../modules/programs/cli/direnv
    ../../modules/programs/cli/eza
    ../../modules/programs/cli/fastfetch
    ../../modules/programs/cli/fzf
    ../../modules/programs/cli/gh
    ../../modules/programs/cli/git
    ../../modules/programs/cli/gpg
    ../../modules/programs/cli/jq
    ../../modules/programs/cli/lazygit
    ../../modules/programs/cli/mpv
    ../../modules/programs/cli/nixvim
    ../../modules/programs/cli/rigprep
    ../../modules/programs/cli/rmpc
    ../../modules/programs/cli/spotify-player
    ../../modules/programs/cli/tmux
    ../../modules/programs/cli/trash-cli
    ../../modules/programs/cli/yazi
    ../../modules/programs/cli/zoxide
    ../../modules/programs/cli/zsh
    ../../modules/programs/cli/no-config/archive
    ../../modules/programs/cli/no-config/media
    ../../modules/programs/cli/no-config/rice
    ../../modules/programs/cli/no-config/typing

    ../../modules/programs/gui/discord
    ../../modules/programs/gui/fcitx5
    ../../modules/programs/gui/firefox
    ../../modules/programs/gui/firejail
    ../../modules/programs/gui/games
    ../../modules/programs/gui/kitty
    ../../modules/programs/gui/localsend
    ../../modules/programs/gui/obs-studio
    ../../modules/programs/gui/obsidian
    ../../modules/programs/gui/spicetify
    ../../modules/programs/gui/swayimg
    ../../modules/programs/gui/thunderbird
    ../../modules/programs/gui/vscode
    ../../modules/programs/gui/zathura
    ../../modules/programs/gui/no-config/graphics
    ../../modules/programs/gui/no-config/networking
    ../../modules/programs/gui/no-config/productivity

    ../../modules/scripts

    ../../modules/desktop/hyprland
    ../../modules/desktop/themes
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
  boot.kernelPackages = pkgs.linuxPackages; # _latest, _zen, _xanmod_latest, _hardened, _rt, _OTHER_CHANNEL, etc.

  # Disks
  fileSystems."/mnt/ssd" = {
    device = "/dev/disk/by-uuid/CC28EE4576AC5AE3";
    fsType = "ntfs-3g";
    options = [
      "uid=1000"
      "gid=100"
      "dmask=0022"
      "fmask=002"
      "exec"
      "nofail"
      "X-mount.mkdir"
    ];
    neededForBoot = false;
  };

  fileSystems."/mnt/hdd1" = {
    device = "/dev/disk/by-uuid/63edc807-ec2a-4461-9a4a-854313c19600";
    fsType = "ext4";
    options = [
      "defaults"
      "nofail"
      "X-mount.mkdir"
    ];
    neededForBoot = false;
  };

  fileSystems."/mnt/hdd2" = {
    device = "/dev/disk/by-uuid/f76ce5a0-dd4f-4a1d-851a-3ceb038e0769";
    fsType = "ext4";
    options = [
      "defaults"
      "nofail"
      "X-mount.mkdir"
    ];
    neededForBoot = false;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
}
