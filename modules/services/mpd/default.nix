{ opts, ... }:
{
  services.mpd = {
    enable = true;
    musicDirectory = opts.mpd.musicDirectory;
    extraConfig = opts.mpd.extraConfig;
  };
}
