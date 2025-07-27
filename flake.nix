{
  description = "A simple NixOS flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    nur.url = "github:nix-community/NUR";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixvim = {
      url = "github:nix-community/nixvim";
      # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
      # url = "github:nix-community/nixvim/nixos-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:nix-community/impermanence";
  };
  outputs =
    inputs@{ nixpkgs, home-manager, ... }:
    let
      whoami = import ./hosts/whoami.nix;
      host = if whoami.host != "" then whoami.host else "default";
      systemType = if whoami.system != "" then whoami.system else "x86_64-linux";
      opts = import ./hosts/${whoami.host}/options.nix;
    in
    {
      nixosConfigurations."${opts.hostname}" = nixpkgs.lib.nixosSystem {
        system = systemType;
        specialArgs = { inherit inputs opts; };
        modules = [
          ./hosts/${opts.hostname}/configuration.nix
        ];
      };
    };
}
