{ lib, opts, ... }:
{
  home-manager.sharedModules = [
    (_: {
      programs.hyprlock = {
        enable = true;
        settings = {
          general = {
            hide_cursor = true;
          };
          background = [
            {
              monitor = opts.hyprlock.monitor1;
              color = "rgb(36, 39, 58)";
              path = opts.hyprlock.background1;
              new_optimizations = true;
              blur_size = 3;
              blur_passes = 2;
              noise = 1.17e-2;
              contrast = 1.0;
              brightness = 1.0;
              vibrancy = 0.21;
              vibrancy_darkness = 0.0;
            }
          ]
          ++ lib.optionals ((opts.hyprlock.monitor2 or "") != "") [
            {
              monitor = opts.hyprlock.monitor2;
              color = "rgb(36, 39, 58)";
              path = opts.hyprlock.background2;
              new_optimizations = true;
              blur_size = 3;
              blur_passes = 2;
              noise = 1.17e-2;
              contrast = 1.0;
              brightness = 1.0;
              vibrancy = 0.21;
              vibrancy_darkness = 0.0;
            }
          ];

          input-field = [
            {
              monitor = opts.hyprlock.monitor1;
              size = "250, 50";
              outline_thickness = 3;
              outer_color = "rgb(198, 160, 246)";
              inner_color = "rgb(36, 39, 58)";
              font_color = "rgb(198, 160, 246)";
              fail_color = "rgb(237, 135, 150)";
              fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
              fail_transition = 300;
              fade_on_empty = false;
              placeholder_text = "Password...";
              dots_size = 0.2;
              dots_spacing = 0.64;
              dots_center = true;
              position = "0, 140";
              halign = "center";
              valign = "bottom";
            }
          ];

          label = [
            {
              monitor = opts.hyprlock.monitor1;
              text = "$TIME";
              font_size = 64;
              font_family = "JetBrains Mono Nerd Font 10";
              color = "rgb(198, 160, 246)";
              position = "0, 16";
              valign = "center";
              halign = "center";
            }
          ]
          ++ lib.optionals ((opts.hyprlock.monitor2 or "") != "") [
            {
              monitor = opts.hyprlock.monitor2;
              text = ''Hello <span text_transform="capitalize" size="larger">$USER!</span>'';
              color = "rgb(198, 160, 246)";
              font_size = 20;
              font_family = "JetBrains Mono Nerd Font 10";
              position = "0, 100";
              halign = "center";
              valign = "center";
            }
          ];
        };
      };
    })
  ];
}
