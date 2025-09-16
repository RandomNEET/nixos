{
  lib,
  opts,
  ...
}:
{
  services.mpd = {
    enable = true;
    startWhenNeeded = opts.mpd.startWhenNeeded or false;
    musicDirectory = opts.mpd.musicDirectory;
    dataDir = opts.mpd.dataDir;
    extraConfig = opts.mpd.extraConfig;
    user = lib.mkIf (opts.mpd.audioType == "pipewire") opts.username;
  };
  systemd.services.mpd.environment = lib.mkIf (opts.mpd.audioType == "pipewire") {
    XDG_RUNTIME_DIR = "/run/user/${toString opts.uid}";
  };
}
