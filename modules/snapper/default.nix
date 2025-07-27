{ opts, ... }:
{
  services.snapper = {
    configs = {
      home = {
        SUBVOLUME = "/home";
        ALLOW_USERS = [ "${opts.username}" ];
        TIMELINE_CREATE = true;
        TIMELINE_CLEANUP = true;
      };
      nix = {
        SUBVOLUME = "/nix";
        ALLOW_USERS = [ "${opts.username}" ];
        TIMELINE_CREATE = true;
        TIMELINE_CLEANUP = true;
      };
    };
    snapshotInterval = "hourly";
    cleanupInterval = "1d";
  };
}
