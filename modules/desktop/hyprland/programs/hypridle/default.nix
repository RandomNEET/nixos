{ lib, opts, ... }:
{
  home-manager.sharedModules = [
    (_: {
      services.hypridle = {
        enable = true;
        settings = {
          general = {
            ignore_dbus_inhibit = false;
            lock_cmd = "pidof hyprlock || hyprlock";
            unlock_cmd = "pkill --signal SIGUSR1 hyprlock";
            before_sleep_cmd = "loginctl lock-session";
            after_sleep_cmd = "sleep 3 && hyprctl dispatch dpms on";
          };
          listener =
            lib.optionals (opts.hypridle.time.lock != "") [
              {
                timeout = opts.hypridle.time.lock;
                on-timeout = "loginctl lock-session";
              }
            ]
            ++ lib.optionals (opts.hypridle.time.dpmsOff != "") [
              {
                timeout = opts.hypridle.time.dpmsOff;
                on-timeout = "hyprctl dispatch dpms off";
                on-resume = "hyprctl dispatch dpms on";
              }
            ]
            ++ lib.optionals (opts.hypridle.time.suspend != "") [
              {
                timeout = opts.hypridle.time.suspend;
                on-timeout = "systemctl suspend";
              }
            ];
        };
      };
    })
  ];
}
