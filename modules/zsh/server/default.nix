{ pkgs, opts, ... }:
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

          initContent = ''
            bindkey '^b' beginning-of-line
            bindkey '^e' end-of-line
            ${if config.programs.tmux.enable then "bindkey -s '^a' 'tmux\\n'" else ""}
          '';

          envExtra = '''';

          shellAliases = {
            tt = "${pkgs.trash-cli}/bin/trash-put";
            ttr = "${pkgs.trash-cli}/bin/trash-restore";
            ttl = "${pkgs.trash-cli}/bin/trash-list";
            tte = "${pkgs.trash-cli}/bin/trash-empty";
            ttrm = "${pkgs.trash-cli}/bin/trash-rm";

            update = "sudo nixos-rebuild switch";
          }
          // (
            if config.programs.lazygit.enable then
              {
                lg = "lazygit";
              }
            else
              { }
          )
          // (
            if config.programs.fastfetch.enable then
              {
                ff = "fastfetch -c ~/.config/fastfetch/ff.jsonc";
                reimufetch = "fastfetch -c ~/.config/fastfetch/reimu.jsonc";
              }
            else
              { }
          );
        };
      }
    )
  ];
}
