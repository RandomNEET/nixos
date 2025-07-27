{ opts, ... }:
{
  home-manager.sharedModules = [
    (_: {
      programs.git = {
        enable = true;
        userName = "${opts.git.userName}";
        userEmail = "${opts.git.userEmail}";
      };
    })
  ];
}
