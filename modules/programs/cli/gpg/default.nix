{ pkgs, opts, ... }:
{
  home-manager.sharedModules = [
    (_: {
      programs.gpg = {
        enable = true;
        homedir = opts.gpg.homedir;
      };
      services.gpg-agent = {
        enable = opts.gpg.agent.enable;
        enableSshSupport = opts.gpg.agent.enableSshSupport;
        enableBashIntegration = true;
        enableZshIntegration = true;
        pinentry.package = pkgs.pinentry-curses;
        pinentry.program = "pinentry-curses";
      };
      home.packages = [ pkgs.pinentry-curses ];
    })
  ];
}
