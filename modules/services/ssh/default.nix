{ opts, ... }:
{
  services.openssh = {
    enable = opts.ssh.system.enable or false;
    ports = opts.ssh.system.ports or [ 22 ];
    authorizedKeysFiles = opts.ssh.system.authorizedKeysFiles;
    settings = opts.ssh.system.settings;
  };
  home-manager.sharedModules = [
    (_: {
      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
        matchBlocks = opts.ssh.home.matchBlocks;
      };
      services.ssh-agent.enable =
        (opts.ssh.home.agent.enable or false) && !(opts.gpg.agent.enableSshSupport or false);
    })
  ];
}
