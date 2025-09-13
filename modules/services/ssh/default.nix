{ opts, ... }:
{
  services.openssh = {
    enable = opts.ssh.daemon.enable;
    ports = opts.ssh.daemon.ports;
    authorizedKeysFiles = opts.ssh.daemon.authorizedKeysFiles;
    settings = opts.ssh.daemon.settings;
  };
  home-manager.sharedModules = [
    (_: {
      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
        matchBlocks = opts.ssh.matchBlocks;
      };
      services.ssh-agent.enable = opts.ssh.agent.enable && !(opts.gpg.agent.enableSshSupport or false);
    })
  ];
}
