{ pkgs, opts, ... }:
{
  programs.zsh.enable = true;
  users.users.${opts.username}.shell = pkgs.zsh;
  home-manager.sharedModules = [
    (_: {
      programs.zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;

        initContent = ''
          bindkey '^k' up-line-or-history
          bindkey '^j' down-line-or-history
          bindkey '^l' forward-char
          bindkey '^h' backward-char
          bindkey '^[l' forward-word
          bindkey '^[h' backward-word
        '';

        envExtra = ''
          export EDITOR="${opts.editor}"
        '';

        shellGlobalAliases = {
          G = "| grep";
        };
        shellAliases = {
          update = "sudo nixos-rebuild switch";
        };
      };
    })
  ];
}
