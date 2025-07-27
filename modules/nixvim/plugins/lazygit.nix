{ ... }:
{
  programs.nixvim = {
    keymaps = [
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
      enable = true;
      settings = {
      };
    };
  };
}
