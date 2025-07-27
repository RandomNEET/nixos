{ ... }:
{
  home-manager.sharedModules = [
    (_: {
      home.file.".config/fastfetch/ascii".source = ./ascii;
      home.file.".config/fastfetch/ff.jsonc".source = ./ff.jsonc;
      home.file.".config/fastfetch/reimu.jsonc".source = ./reimu.jsonc;
      programs.fastfetch = {
        enable = true;
      };
    })
  ];
}
