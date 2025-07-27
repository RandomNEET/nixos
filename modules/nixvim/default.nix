{
  inputs,
  pkgs,
  opts,
  ...
}:
{
  home-manager.sharedModules = [
    (_: {
      imports = [
        inputs.nixvim.homeModules.nixvim
        ./core
        ./plugins
        ./themes
      ];

      programs.nixvim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
        globals.mapleader = " ";
        clipboard = {
          register = "unnamedplus";
          providers = {
            wl-copy.enable = true;
            xclip.enable = true;
          };
        };
        withNodeJs = opts.nixvim.withNodeJs;
        withPerl = opts.nixvim.withPerl;
        withPython3 = opts.nixvim.withPython3;
        withRuby = opts.nixvim.withRuby;

        extraPackages =
          with pkgs;
          (
            [
              ripgrep
              lynx
              fd
              ghostscript
            ]
            ++ lib.optionals opts.nixvim.conform.enable [
              # Formatters
              nixfmt-rfc-style
              shfmt
              stylua
              prettier
              prettierd
              isort
              black
            ]
            ++ lib.optionals opts.nixvim.lint.enable [
              # Linters
              commitlint
              luajitPackages.luacheck
              markdownlint-cli
              nodePackages.jsonlint
              pylint
              ruff
              shellcheck
              yamllint
            ]
          );
      };

      home.packages = with pkgs; [ ];
    })
  ];
}
