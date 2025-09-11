{ opts, ... }:
{
  virtualisation.docker = {
    enable = true;
  };
  users = {
    users = {
      ${opts.username} = {
        extraGroups = [ "docker" ];
      };
    };
  };
}
