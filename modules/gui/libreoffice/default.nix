{ pkgs, ... }:
{
  home-manager.sharedModules = [
    (_: {
      home.packages = with pkgs; [ libreoffice ];
      xdg.mimeApps = {
        enable = true;
        defaultApplications = {
          "application/msword" = "writer.desktop";
          "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = "writer.desktop";
          "application/msexcel" = "calc.desktop";
          "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = "calc.desktop";
          "application/mspowerpoint" = "impress.desktop";
          "application/vnd.openxmlformats-officedocument.presentationml.presentation" = "impress.desktop";
        };
      };
    })
  ];
}
