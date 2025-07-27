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

          oh-my-zsh = {
            enable = true;
            plugins = [
              "vi-mode"
            ];
            theme = "simple";
          };

          initContent = ''
            bindkey '^k' up-line-or-history
            bindkey '^j' down-line-or-history
            bindkey '^l' forward-char
            bindkey '^h' backward-char
            bindkey '^[l' forward-word
            bindkey '^[h' backward-word
          '';

          envExtra = ''
            export VI_MODE_SET_CURSOR=true
            MODE_INDICATOR="%F{red}<<<%f"
          '';

          shellGlobalAliases = {
            G = "| grep";
          };
          shellAliases = {
            update = "sudo nixos-rebuild switch";
          };
        };
      }
    )
  ];
}
