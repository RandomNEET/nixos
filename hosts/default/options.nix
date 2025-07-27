rec {
  hostname = "nixos";
  hostType = "";
  gpu = "nvidia";
  locale = "en_US.UTF-8";
  timezone = "Asia/Shanghai";
  kbdLayout = "us";
  kbdVariant = "";
  consoleKeymap = "us";
  rootpasswd = "$6$1bNtqKFsObhMC1OG$THnog0HqmR/GnN.0IwndZzuijVMiV0cZIPUjmCvDs6gsjHAc.FYfcIlKmiMx2hy2gbd814Br1uNAhiyKl4W9g.";

  username = "howl";
  userpasswd = "$6$.FVrKngH1eXjNYi9$lsTAUQvvJyB209fhkf3g5E12iCcgNdDZKW0XTwCp7i3lNwM8gjNq3kRgjW4WIBV68YETysoDCHhKtSIncPT3n1";
  editor = "nvim";
  terminal = "";
  terminalFileManager = "yazi";
  browser = "";
  emailClient = "";

  ssh = {
    dir = "/home/${username}/.vault/ssh";
    matchBlocks = { };
    daemon = {
      enable = true;
      ports = [
        22
      ];
      authorizedKeysFiles = [ "${ssh.dir}/..." ];
      settings = {
        PasswordAuthentication = false;
      };
    };
    agent.enable = true;
  };

  gpg = {
    dir = "/home/${username}/.vault/gpg";
    agent = {
      enable = true;
      enableSshSupport = false;
    };
  };

  proxy = {
    method = ""; # tproxy lpf
    settingsFile = "/home/${username}/.vault/proxy/${proxy.method}/...";
  };

  git = {
    userName = "";
    userEmail = "";
  };

  hyprland = {
    monitor = [ ];
    workspaceBind = "";
  };

  hyprlock = {
    monitor1 = "";
    monitor2 = "";
    background1 = "";
    background2 = "";
  };

  hypridle = {
    time = {
      lock = "";
      dpmsOff = "";
      suspend = "";
    };
  };

  wallpaper = {
    dir = "";
    default = "";
  };
}
