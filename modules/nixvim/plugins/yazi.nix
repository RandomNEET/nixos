{ lib, opts, ... }:
{
  programs.nixvim = {
    keymaps = lib.mkIf opts.nixvim.yazi.enable [
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>yy";
        action = "<cmd>Yazi<cr>";
        options = {
          desc = "Open yazi at the current file";
        };
      }
      {
        key = "<leader>cw";
        action = "<cmd>Yazi cwd<cr>";
        options = {
          desc = "Open the file manager in nvim's working directory";
        };
      }
      {
        key = "<c-up>";
        action = "<cmd>Yazi toggle<cr>";
        options = {
          desc = "Resume the last yazi session";
        };
      }
    ];
    plugins.yazi = {
      enable = opts.nixvim.yazi.enable;
      settings = {
        enable_mouse_support = true;
        open_for_directories = true;
        yazi_floating_window_border = "rounded";
      };
    };
  };
}
