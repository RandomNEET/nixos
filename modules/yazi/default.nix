{ pkgs, opts, ... }:
{
  home-manager.sharedModules = [
    (_: {
      home.file.".config/yazi/theme.toml".source = ./catppuccin-mocha-mauve.toml;
      programs.yazi = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
        settings = {
          mgr = {
            show_hidden = false;
            show_symlink = true;
            sort_dir_first = true;
            linemode = "size"; # or size, permissions, owner, mtime
            ratio = [
              # or 0 3 4
              1
              3
              4
            ];
          };
          preview = {
            # wrap = "yes";
            tab_size = 4;
            image_filter = "triangle"; # from fast to slow but high quality: nearest, triangle, catmull-rom, lanczos3
            max_width = 3840; # maybe 1000
            max_height = 2160; # maybe 1000
            image_quality = 90;
          };
          plugin = {
            repend_preloaders = [
              {
                mime = "{audio,video,image}/*";
                run = "mediainfo";
              }
              {
                mime = "application/subrip";
                run = "mediainfo";
              }
            ];
            prepend_previewers = [
              {
                name = "*/";
                run = ''piper -- eza -TL=3 --color=always --icons=always --group-directories-first --no-quotes "$1"'';
              }
              {
                name = "*.tar*";
                run = ''piper --format=url -- tar tf "$1"'';
              }
              {
                name = "*.md";
                run = ''piper -- CLICOLOR_FORCE=1 glow -w=$w -s=dark "$1"'';
              }
              {
                mime = "{audio,video,image}/*";
                run = "mediainfo";
              }
              {
                mime = "application/subrip";
                run = "mediainfo";
              }
            ];
          };
        };
        keymap = {
          mgr.prepend_keymap = [
            # Goto
            {
              on = [
                "g"
                "h"
              ];
              run = "cd ~";
              desc = "Go home";
            }
            {
              on = [
                "g"
                "n"
              ];
              run = "cd ~/nixos";
              desc = "Go ~/nixos";
            }
            {
              on = [
                "g"
                "d"
              ];
              run = "cd ~/dls";
              desc = "Go ~/dls";
            }
            {
              on = [
                "g"
                "r"
              ];
              run = "cd ~/repo";
              desc = "Go ~/repo";
            }
            {
              on = [
                "g"
                "t"
              ];
              run = "cd ~/tmp";
              desc = "Go ~/tmp";
            }
            {
              on = [
                "g"
                "<Space>"
              ];
              run = "cd --interactive";
              desc = "Jump interactively";
            }
            {
              on = [
                "g"
                "f"
              ];
              run = "follow";
              desc = "Follow hovered symlink";
            }
            # Plugins
            {
              on = "<C-d>";
              run = "plugin diff";
              desc = "Diff the selected with the hovered file";
            }
            {
              on = "T";
              run = "plugin toggle-pane min-preview";
              desc = "Show or hide the preview pane";
            }
            {
              on = "T";
              run = "plugin toggle-pane max-preview";
              desc = "Maximize or restore the preview pane";
            }
          ];
        };
        initLua = ./init.lua;
        plugins = {
          piper = pkgs.yaziPlugins.piper;
          git = pkgs.yaziPlugins.git;
          diff = pkgs.yaziPlugins.diff;
          mediainfo = pkgs.yaziPlugins.mediainfo;
          lazygit = pkgs.yaziPlugins.lazygit;
          full-border = pkgs.yaziPlugins.full-border;
          yatline = pkgs.yaziPlugins.yatline;
          toggle-pane = pkgs.yaziPlugins.toggle-pane;
        };
      };

      home.packages = with pkgs; [
        mediainfo
        glow
      ];
    })
  ];
}
