{ ... }:
{
  home-manager.sharedModules = [
    (_: {
      programs.swayimg = {
        enable = true;
        settings = {
          viewer = {
            window = "#1e1e2e80";
            scale = "optimal";
            antialiasing = "mks13";
          };
          font = {
            name = "JetBrainsMono Nerd Font";
            size = 12;
            color = "#cdd6f4ff";
            shadow = "#1e1e2ed0";
            background = "#1e1e2e00";
          };
          "info.viewer" = {
            top_left = "+name,+format,+filesize,+imagesize,+exif";
            top_right = "index";
            bottom_left = "scale,frame";
            bottom_right = "status";
          };
          "keys.viewer" = {
            "h" = "step_left 10";
            "l" = "step_right 10";
            "k" = "step_up 10";
            "j" = "step_down 10";
            "Shift+h" = "prev_file";
            "Shift+l" = "next_file";
            "Shift+k" = "zoom +10";
            "Shift+j" = "zoom -10";
            "Shift+r" = "rand_file";
          };
        };
      };
      xdg.mimeApps = {
        enable = true;
        defaultApplications = {
          "image/avif" = "swayimg.desktop";
          "image/bmp" = "swayimg.desktop";
          "image/gif" = "swayimg.desktop";
          "image/heif" = "swayimg.desktop";
          "image/jpeg" = "swayimg.desktop";
          "image/jpg" = "swayimg.desktop";
          "image/pbm" = "swayimg.desktop";
          "image/pjpeg" = "swayimg.desktop";
          "image/png" = "swayimg.desktop";
          "image/svg+xml" = "swayimg.desktop";
          "image/tiff" = "swayimg.desktop";
          "image/webp" = "swayimg.desktop";
          "image/x-bmp" = "swayimg.desktop";
          "image/x-exr" = "swayimg.desktop";
          "image/x-png" = "swayimg.desktop";
          "image/x-portable-anymap" = "swayimg.desktop";
          "image/x-portable-bitmap" = "swayimg.desktop";
          "image/x-portable-graymap" = "swayimg.desktop";
          "image/x-portable-pixmap" = "swayimg.desktop";
          "image/x-targa" = "swayimg.desktop";
          "image/x-tga" = "swayimg.desktop";
          "image/x-pcx" = "swayimg.desktop";
          "image/x-xbitmap" = "swayimg.desktop";
        };
      };
    })
  ];
}
