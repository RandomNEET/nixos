{ inputs, opts, ... }:
{
  imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];
  services.flatpak = {
    enable = true;
    packages = opts.flatpak.packages.system;
  };
  home-manager.sharedModules = [
    (_: {
      imports = [ inputs.nix-flatpak.homeManagerModules.nix-flatpak ];
      services.flatpak.packages = opts.flatpak.packages.user;
    })
  ];
}
