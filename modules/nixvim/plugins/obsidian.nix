{ opts, ... }:
{
  programs.nixvim = {
    keymaps = [
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
        enable = true;
        settings = {
          completion = {
            min_chars = 2;
            blink = true;
          };
          new_notes_location = "current_dir";
          workspaces = [
            {
              name = "default";
              path = "~/${opts.obsidian.vaults.default.target}";
            }
            {
              name = "dev";
              path = "~/${opts.obsidian.vaults.default.target}/dev";
            }
            {
              name = "2hu";
              path = "~/${opts.obsidian.vaults.default.target}/2hu";
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
