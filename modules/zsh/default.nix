{
  pkgs,
  opts,
  ...
}:
{
  programs.zsh.enable = true;
  users.users.${opts.username}.shell = pkgs.zsh;
  home-manager.sharedModules = [
    (
      { config, ... }:
      {
        programs.zsh = {
          enable = true;
          enableCompletion = true;
          autosuggestion.enable = true;
          syntaxHighlighting.enable = true;
          dotDir = "${config.xdg.configHome}/zsh";
          history = {
            path = "${config.xdg.dataHome}/zsh/history";
            ignoreAllDups = true;
            ignoreDups = true;
            saveNoDups = true;
            size = 100000;
          };
          oh-my-zsh = opts.zsh.oh-my-zsh;
          initContent = opts.zsh.initContent;
          envExtra = opts.zsh.envExtra;
          shellGlobalAliases = opts.zsh.shellGlobalAliases;
          shellAliases = opts.zsh.shellAliases;
        };
      }
    )
  ];
}
