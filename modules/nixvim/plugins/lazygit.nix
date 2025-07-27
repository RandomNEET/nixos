{ lib, opts, ... }:
{
  programs.nixvim = {
    keymaps = lib.mkIf opts.nixvim.lazygit.enable [
      {
        mode = [
          "n"
        ];
        key = "<leader>lg";
        action = "<cmd>LazyGit<cr>";
        options = {
          desc = "Open lazygit";
        };
      }
    ];
    plugins.lazygit = {
      enable = opts.nixvim.lazygit.enable;
      settings = {
      };
    };
  };
}
