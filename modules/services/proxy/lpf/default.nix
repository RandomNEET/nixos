{ opts, ... }:
{
  services.xray = {
    enable = true;
    settingsFile = opts.proxy.settingsFile;
  };
}
