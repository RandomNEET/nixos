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

    ../../modules/system/docker
    ../../modules/system/garbage-collect
    ../../modules/system/gpu
    ../../modules/system/virtualisation

    ../../modules/services/automount
    ../../modules/services/cron
    ../../modules/services/frp
    ../../modules/services/jellyfin
    ../../modules/services/mpd
    ../../modules/services/proxy
    ../../modules/services/samba
    ../../modules/services/ssh

    ../../modules/programs/cli/bash
    ../../modules/programs/cli/bat
    ../../modules/programs/cli/btop
    ../../modules/programs/cli/direnv
    ../../modules/programs/cli/eza
    ../../modules/programs/cli/fastfetch
    ../../modules/programs/cli/fzf
    ../../modules/programs/cli/git
    ../../modules/programs/cli/jq
    ../../modules/programs/cli/lazygit
    ../../modules/programs/cli/nixvim
    ../../modules/programs/cli/rigprep
    ../../modules/programs/cli/tmux
    ../../modules/programs/cli/trash-cli
    ../../modules/programs/cli/yazi
    ../../modules/programs/cli/zoxide
    ../../modules/programs/cli/zsh
    ../../modules/programs/cli/no-config/archive
    ../../modules/programs/cli/no-config/rice

    ../../modules/scripts
  ];

  # Define system packages here
  environment.systemPackages = with pkgs; [
    iptables
    xray
  ];

  # Home-manager config
  home-manager.sharedModules = [
    (_: {
      home.packages = with pkgs; [
        flac
        qq
      ];
    })
  ];

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages; # _latest, _zen, _xanmod_latest, _hardened, _rt, _OTHER_CHANNEL, etc.

  # GPU
  hardware.nvidia.prime = {
    # Make sure to use the correct Bus ID values for your system!
    nvidiaBusId = "PCI:07:0:0";
    amdgpuBusId = "PCI:01:0:0";
  };

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
    6600
    6881
    7102
    8000
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
