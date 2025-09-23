{
  lib,
  opts,
  ...
}:
{
  services.mpd = {
    enable = true;
    network =
      opts.mpd.network or {
        listenAddress = "127.0.0.1";
        port = 6600;
      };
    credentials = opts.mpd.credentials or [ ];
    startWhenNeeded = opts.mpd.startWhenNeeded or false;
    dataDir = opts.mpd.dataDir or "/var/lib/mpd";
    musicDirectory = opts.mpd.musicDirectory or "/var/lib/mpd/music";
    extraConfig = opts.mpd.extraConfig;
    user = lib.mkIf (opts.mpd.audioType == "pipewire") opts.username;
  };
  systemd.services.mpd.environment = lib.mkIf (opts.mpd.audioType == "pipewire") {
    XDG_RUNTIME_DIR = "/run/user/${toString opts.uid}";
  };
}
