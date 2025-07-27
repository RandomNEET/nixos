{ opts, ... }:
{
  programs.nixvim = {
    keymaps = [
      {
        mode = "n";
        action = "<cmd>ObsidianOpen<CR>";
        key = "<leader>obo";
        options = {
          desc = "Open note";
        };
      }
      {
        mode = "n";
        action = "<cmd>ObsidianNew<CR>";
        key = "<leader>obn";
        options = {
          desc = "New note";
        };
      }
      {
        mode = "n";
        action = "<cmd>ObsidianQuickSwitch<CR>";
        key = "<leader>obq";
        options = {
          desc = "Quick switch note";
        };
      }
      {
        mode = "n";
        action = "<cmd>ObsidianSearch<CR>";
        key = "<leader>obs";
        options = {
          desc = "Search notes";
        };
      }
      {
        mode = "n";
        action = "<cmd>ObsidianWorkspace<CR>";
        key = "<leader>obw";
        options = {
          desc = "Workspace switch";
        };
      }
      {
        mode = "n";
        action = "<cmd>ObsidianRename<CR>";
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
        };
      };
    };
  };
}
