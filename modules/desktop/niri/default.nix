{
  config,
  lib,
  pkgs,
  opts,
  ...
}:
{
  imports = [
    ./programs/rofi
    ./programs/swayidle
    ./programs/swaylock
    ./programs/swaync
    ./programs/waybar
    ./programs/wlogout
    ./scripts
  ];

  systemd.user.services.random-walls = {
    description = "Change wallpaper every hour";
    startAt = "hourly";
    script = "exec /run/current-system/sw/bin/bash /home/${opts.username}/nixos/modules/desktop/niri/scripts/random-walls.sh";
    serviceConfig = {
      Type = "oneshot";
      Environment = "PATH=/etc/profiles/per-user/${opts.username}/bin:/run/current-system/sw/bin";
    };
  };

  programs.niri = {
    enable = true;
  };

  home-manager.sharedModules = [
    (
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          swaybg
          cliphist
          libnotify
          brightnessctl
          networkmanagerapplet
          pamixer
          pavucontrol
          playerctl
          wtype
          wl-clipboard
          jq
          xwayland-satellite
        ];

        home.sessionVariables = {
          TERMINAL = opts.terminal;
          EDITOR = opts.editor;
          BROWSER = opts.browser;
        };

        xdg = {
          enable = true;
          portal = {
            enable = true;
            xdgOpenUsePortal = true;
            extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
            configPackages = [ pkgs.xdg-desktop-portal-gtk ];
            config.common.default = "gtk";
          };
        };

        home.file.".config/niri/config.kdl".source = ./config.kdl;
      }
    )
  ];
}
