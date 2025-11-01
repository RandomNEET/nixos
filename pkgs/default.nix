{ pkgs, ... }:
let
  dir = ./.;
  entries = builtins.readDir dir;

  pkgDirs = builtins.filter (
    name:
    entries.${name} == "directory"
    && builtins.pathExists (dir + "/${name}/default.nix")
    && builtins.substring 0 1 name != "."
  ) (builtins.attrNames entries);
in
builtins.listToAttrs (
  map (name: {
    name = name;
    value = pkgs.callPackage (dir + "/${name}/default.nix") { };
  }) pkgDirs
)
