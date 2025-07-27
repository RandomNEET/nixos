{ pkgs, opts, ... }:
{
  home-manager.sharedModules = [
    (_: {
      programs.obsidian = {
        enable = true;
        defaultSettings = {
          corePlugins = [
            "backlink"
            "bookmarks"
            "canvas"
            "command-palette"
            "daily-notes"
            "editor-status"
            "file-explorer"
            "file-recovery"
            "global-search"
            "graph"
            "note-composer"
            "outgoing-link"
            "outline"
            "page-preview"
            "switcher"
            "tag-pane"
            "templates"
            "word-count"
          ];
          communityPlugins = [
            {
              pkg = pkgs.obsidian-livesync;
              enable = true;
            }
          ];
          themes = [
            {
              pkg = pkgs.obsidian-catppuccin;
              enable = true;
            }
          ];
          appearance = {
            cssTheme = "Catppuccin";
            interfaceFontFamily = "JetBrainsMono Nerd Font";
            textFontFamily = "JetBrainsMono Nerd Font";
            monospaceFontFamily = "JetBrainsMono Nerd Font";
          };
        };
        vaults = opts.obsidian.vaults;
      };
    })
  ];
}
