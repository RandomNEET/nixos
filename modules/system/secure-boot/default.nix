{
  inputs,
  lib,
  pkgs,
  opts,
  ...
}:
let
  sources = import ./nix/sources.nix;
  lanzaboote = import sources.lanzaboote;
in
{
  imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];

  environment.systemPackages = [
    # For debugging and troubleshooting Secure Boot.
    pkgs.sbctl
  ];

  # Lanzaboote currently replaces the systemd-boot module.
  # This setting is usually set to true in configuration.nix
  # generated at installation time. So we force it to false
  # for now.
  boot = {
    loader.systemd-boot.enable = lib.mkIf (opts.lanzaboote ? enable && opts.lanzaboote.enable) (
      lib.mkForce false
    );

    lanzaboote = {
      enable = opts.lanzaboote.enable or false;
      pkiBundle = opts.lanzaboote.pkiBundle or "/var/lib/sbctl";
    };
  };
}
