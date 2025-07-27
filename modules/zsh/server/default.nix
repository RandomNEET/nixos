{
  config,
  pkgs,
  opts,
  ...
}:
{
  programs.zsh.enable = true;
  users.users.${opts.username} = {
    shell = pkgs.zsh;
  };

  home-manager.sharedModules = [

    (
      { ... }:
      {
        programs.zsh = {
          enable = true;
          enableCompletion = true;
          autosuggestion.enable = true;
          syntaxHighlighting.enable = true;

          shellAliases = {
            ff = "fastfetch -c ~/.config/fastfetch/ff.jsonc";
            reimufetch = "fastfetch -c ~/.config/fastfetch/reimu.jsonc";
            update = "sudo nixos-rebuild switch";
          };

          envExtra = '''';

          initContent = '''';
        };
      }
    )
  ];
}
