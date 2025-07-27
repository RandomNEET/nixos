{ opts, ... }:
{
  services.xray.enable = true;
  services.xray.settingsFile = opts.proxy.settingsFile;
}
