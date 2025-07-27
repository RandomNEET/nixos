{ pkgs, ... }:
{
  obsidian-livesync = pkgs.callPackage ./obsidian-livesync { };
  obsidian-catppuccin = pkgs.callPackage ./obsidian-catppuccin { };
}
