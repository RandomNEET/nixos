{ opts, ... }:
{
  services.snapper = {
    configs = opts.snapper.config;
    snapshotInterval = opts.snapper.snapshotInterval;
    cleanupInterval = opts.snapper.cleanupInterval;
  };
}
