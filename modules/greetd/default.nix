{ config, pkgs, ... }:
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command =
          if config.programs.hyprland.enable then
            "${pkgs.tuigreet}/bin/tuigreet --time --theme 'border=lightblue;text=white;prompt=lightcyan;time=lightyellow;action=white;button=lightred;container=black;input=white' --cmd hyprland"
          else if config.programs.zsh.enable then
            "${pkgs.tuigreet}/bin/tuigreet --time --theme 'border=lightblue;text=white;prompt=lightcyan;time=lightyellow;action=white;button=lightred;container=black;input=white' --cmd zsh"
          else
            "${pkgs.tuigreet}/bin/tuigreet --time --theme 'border=lightblue;text=white;prompt=lightcyan;time=lightyellow;action=white;button=lightred;container=black;input=white' --cmd bash";
        user = "greeter";
      };
    };
  };
  environment.systemPackages = with pkgs; [
    pkgs.tuigreet
  ];
}
