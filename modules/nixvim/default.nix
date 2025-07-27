{ inputs, pkgs, ... }:
{
  home-manager.sharedModules = [
    (_: {
      imports = [
        inputs.nixvim.homeModules.nixvim
        ./core
        ./plugins
        ./themes
      ];

      home.packages = with pkgs; [ ];
      programs.nixvim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
        clipboard = {
          register = "unnamedplus";
          providers = {
            wl-copy.enable = true;
            xclip.enable = true;
          };
        };
        globals.mapleader = " ";
        extraPackages = with pkgs; [
          ripgrep
          lynx
          fd
          ghostscript
          # Formatters
          nixfmt-rfc-style
          shfmt
          stylua
          prettier
          prettierd
          isort
          black
          # Linters
          commitlint
          luajitPackages.luacheck
          markdownlint-cli
          nodePackages.jsonlint
          pylint
          ruff
          shellcheck
          yamllint
        ];
      };
    })
  ];
}
