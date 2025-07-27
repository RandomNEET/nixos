{ opts, ... }:
{
  services.frp = {
    enable = true;
    role = opts.frp.fole;
    settings = opts.frp.settings;
  };
}
