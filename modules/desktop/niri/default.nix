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
    ./programs/swww
    ./programs/waybar
    ./programs/wlogout
    ./scripts
  ];

  systemd.user.services.random-wall = {
    description = "Change wallpaper every hour";
    startAt = "hourly";
    script = "exec /run/current-system/sw/bin/bash ${./scripts/swww-randomize-multi.sh}";
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
          cliphist
          libnotify
          brightnessctl
          networkmanagerapplet
          pamixer
          pavucontrol
          playerctl
          wtype
          wl-clipboard
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
