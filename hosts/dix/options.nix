rec {
  hostname = "dix";
  system = "x86_64-linux";
  role = "desktop";

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
  terminal = "kitty";
  terminalFileManager = "yazi";
  browser = "firefox";
  emailClient = "thunderbird";

  # https://github.com/nix-community/lanzaboote/blob/master/docs/QUICK_START.md
  secure-boot = {
    enable = true;
    lanzaboote = {
      enable = true;
      pkiBundle = "/nix/persist/var/lib/sbctl";
    };
  };

  snapper = {
    config = {
      home = {
        SUBVOLUME = "/home";
        ALLOW_USERS = [ "${username}" ];
        TIMELINE_CREATE = true;
        TIMELINE_CLEANUP = true;
      };
    };
    snapshotInterval = "hourly";
    cleanupInterval = "1d";
  };

  ssh = {
    dir = "/home/${username}/.vault/ssh";
    matchBlocks = {
      "github.com" = {
        hostname = "github.com";
        user = "git";
        identityFile = "${ssh.dir}/gh-howl";
      };
      "nasix" = {
        hostname = "192.168.0.56";
        port = 22;
        user = "howl";
        identityFile = "${ssh.dir}/nasix";
      };
    };
    daemon = {
      enable = true;
      ports = [
        22
      ];
      authorizedKeysFiles = [ "${ssh.dir}/dix.pub" ];
      settings = {
        PasswordAuthentication = false;
      };
    };
    agent.enable = false;
  };

  gpg = {
    homedir = "/home/${username}/.vault/gpg";
    agent = {
      enable = true;
      enableSshSupport = true; # Automatically disable ssh-agent if set to true
    };
  };

  proxy = {
    method = "tproxy"; # tproxy lpf
    settingsFile = "/home/${username}/.vault/proxy/${proxy.method}/outsider/default.json";
  };

  git = {
    userName = "howl";
    userEmail = "howell.ding@outlook.com";
  };

  nixvim = {
    withNodeJs = false;
    withPerl = false;
    withPython3 = true;
    withRuby = false;

    lsp.enable = true;
    treesitter.enable = true; # Automatically disable noice if set to false
    lint.enable = true;
    conform.enable = true;
    copilot.enable = true;
    noice.enable = true; # Require treesitter
    snack = {
      image.enable = true;
    };
    obsidian = {
      workspaces = [
        {
          name = "default";
          path = "~/${obsidian.vaults.default.target}";
        }
        {
          name = "daily";
          path = "~/${obsidian.vaults.default.target}/daily";
          overrides = {
            notes_subdir = "daily";
          };
        }
        {
          name = "develop";
          path = "~/${obsidian.vaults.default.target}/develop";
          overrides = {
            notes_subdir = "develop";
          };
        }
      ];
    };
  };

  hyprland = {
    monitor = [
      "desc:SAC G7u Pro 0001, 3840x2160@160, 0x0, 1.5"
      "desc:KOS KOIOS K2718UD 0000000000000, 3840x2160@60, 2560x-600, 1.5, transform, 1"
    ];
    workspaceBind = ''
      workspace = 1, monitor:desc:SAC G7u Pro 0001, default:true;
      workspace = 10, monitor:desc:KOS KOIOS K2718UD 0000000000000, default:true;
    '';
  };

  hyprlock = {
    monitor1 = "DP-1";
    monitor2 = "HDMI-A-1";
    background1 = "${wallpaper.dir}/horizontal/mocha/greenbus.jpg";
    background2 = "${wallpaper.dir}/vertical/anime/76257949_p0.jpg";
  };

  hypridle = {
    time = {
      lock = "300";
      dpmsOff = "";
      suspend = "";
    };
  };

  wallpaper = {
    dir = "/home/${username}/pic/wallpapers";
    default = "${wallpaper.dir}/universal/black.png";
  };

  obsidian = {
    vaults = {
      default = {
        enable = true;
        target = "doc/obsidian";
      };
    };
  };

  samba = {
    settings = {
    };
  };

  frp = {
    role = ""; # server client
    settings = {
    };
  };
}
