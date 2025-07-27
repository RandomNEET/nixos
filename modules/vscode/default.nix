{
  lib,
  pkgs,
  ...
}:
{
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "vscode" ];
  home-manager.sharedModules = [
    (_: {
      programs.vscode = {
        enable = true;
        package = pkgs.vscode;
        profiles.default = {
          extensions = with pkgs.vscode-extensions; [
            github.copilot
            github.copilot-chat
            ms-vscode-remote.remote-ssh
            ms-vscode-remote.remote-ssh-edit
            ms-vscode.remote-explorer
            esbenp.prettier-vscode
            yzhang.markdown-all-in-one
            asvetliakov.vscode-neovim
            catppuccin.catppuccin-vsc
            catppuccin.catppuccin-vsc-icons
          ];
        };
      };
    })
  ];
}
