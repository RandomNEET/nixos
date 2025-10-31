{
  config,
  lib,
  opts,
  ...
}:
let
  docDir = lib.removePrefix "$HOME/" opts.xdg.userDirs.documents;
in
{
  programs.nixvim = {
    keymaps = lib.mkIf config.programs.obsidian.enable [
      {
        mode = "n";
        action = "<cmd>Obsidian new<CR>";
        key = "<leader>obn";
        options = {
          desc = "New note";
        };
      }
      {
        mode = "n";
        action = "<cmd>Obsidian quick_switch<CR>";
        key = "<leader>obq";
        options = {
          desc = "Quick switch note";
        };
      }
      {
        mode = "n";
        action = "<cmd>Obsidian search<CR>";
        key = "<leader>obs";
        options = {
          desc = "Search notes";
        };
      }
      {
        mode = "n";
        action = "<cmd>Obsidian workspace<CR>";
        key = "<leader>obw";
        options = {
          desc = "Workspace switch";
        };
      }
      {
        mode = "n";
        action = "<cmd>Obsidian rename<CR>";
        key = "<leader>obr";
        options = {
          desc = "Rename note";
        };
      }
    ];
    plugins = {
      obsidian = {
        enable = config.programs.obsidian.enable;
        settings = {
          completion = {
            min_chars = 2;
            blink = true;
          };
          new_notes_location = "current_dir";
          workspaces =
            opts.nixvim.obsidian.workspaces or [
              {
                name = "notes";
                path = "~/${docDir}/notes";
              }
            ];
          picker = {
            name = "snacks.pick";
          };
          legacy_commands = false;
        };
      };
    };
  };
}
