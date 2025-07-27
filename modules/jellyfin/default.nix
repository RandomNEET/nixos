{ pkgs, opts, ... }:
{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = "${opts.username}";
  };
  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg
  ];
}
