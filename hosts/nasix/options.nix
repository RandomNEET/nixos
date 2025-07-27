rec {
  hostname = "nasix";
  hostType = "server";
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
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "${ssh.dir}/gh-howl";
      };
      "dix" = {
        hostname = "192.168.0.29";
        port = 22;
        user = "howl";
        identityFile = "${ssh.dir}/dix";
      };
    };
    daemon = {
      enable = true;
      ports = [
        22
      ];
      authorizedKeysFiles = [ "${ssh.dir}/nasix.pub" ];
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
    method = "lpf"; # tproxy lpf
    settingsFile = "/home/${username}/.vault/proxy/${proxy.method}/motherly-outside/docker.json";
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

  obsidian = {
    vaults = {
      name = {
        enable = true;
        target = "";
      };
    };
  };
}
