{ ... }:
{
  home-manager.sharedModules = [
    (_: {
      services.ssh-agent.enable = true;
      programs.ssh = {
        enable = true;
        addKeysToAgent = "1h";
        matchBlocks = {
          "github.com" = {
            hostname = "github.com";
            user = "git";
            identityFile = "~/.vault/ssh/gh-howl";
          };
          "dix" = {
            hostname = "192.168.0.29";
            port = 22;
            user = "howl";
            identityFile = "~/.vault/ssh/dix";
          };
          "nasix" = {
            hostname = "192.168.0.56";
            port = 22;
            user = "howl";
            identityFile = "~/.vault/ssh/nasix";
          };
        };
      };
    })
  ];
}
