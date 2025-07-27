{ pkgs, opts, ... }:
{
  virtualisation.docker = {
    enable = true;
  };
  hardware.nvidia-container-toolkit =
    if opts.gpu == "nvidia" then
      {
        enable = true;
      }
    else
      { };
  users = {
    users = {
      ${opts.username} = {
        extraGroups = [ "docker" ];
      };
    };
  };
}
