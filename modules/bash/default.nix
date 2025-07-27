{ ... }:
{
  home-manager.sharedModules = [
    (_: {
      programs.bash = {
        enable = true;

        historyFileSize = 100000;
        historyFile = "\${XDG_DATA_HOME}/bash/history";

        bashrcExtra = '''';

        initExtra = '''';

        profileExtra = '''';

        shellAliases = {
          update = "sudo nixos-rebuild switch";
        };
      };
    })
  ];
}
