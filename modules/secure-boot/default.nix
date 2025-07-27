{
  inputs,
  pkgs,
  lib,
  opts,
  ...
}:
let
  sources = import ./nix/sources.nix;
  lanzaboote = import sources.lanzaboote;
in
{
  imports = [ inputs.lanzaboote.nixosModules.lanzaboote ];

  config = lib.mkIf opts.secure-boot.enable {
    environment.systemPackages = [
      # For debugging and troubleshooting Secure Boot.
      pkgs.sbctl
    ];

    # Lanzaboote currently replaces the systemd-boot module.
    # This setting is usually set to true in configuration.nix
    # generated at installation time. So we force it to false
    # for now.
    boot.loader.systemd-boot.enable = lib.mkForce false;

    boot.lanzaboote = opts.secure-boot.lanzaboote;
  };
}
