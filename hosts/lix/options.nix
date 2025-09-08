rec {
  hostname = "lix";
  system = "x86_64-linux";

  gpu = "intel";
  gpuType = "integrated";
  locale = "en_US.UTF-8";
  timezone = "Asia/Shanghai";
  kbdLayout = "us";
  kbdVariant = "";
  consoleKeymap = "us";
  hibernate = true;

  rootpasswd = "$6$1bNtqKFsObhMC1OG$THnog0HqmR/GnN.0IwndZzuijVMiV0cZIPUjmCvDs6gsjHAc.FYfcIlKmiMx2hy2gbd814Br1uNAhiyKl4W9g.";
  username = "howl";
  userpasswd = "$6$.FVrKngH1eXjNYi9$lsTAUQvvJyB209fhkf3g5E12iCcgNdDZKW0XTwCp7i3lNwM8gjNq3kRgjW4WIBV68YETysoDCHhKtSIncPT3n1";

  editor = "nvim";
  terminal = "kitty";
  terminalFileManager = "yazi";
  browser = "firefox";
  emailClient = "thunderbird";
  xdg = {
    userDirs = {
      desktop = null; # null or "$HOME/dsk"
      documents = "$HOME/doc";
      download = "$HOME/dls";
      music = "$HOME/mus";
      pictures = "$HOME/pic";
      publicShare = "$HOME/pub";
      templates = "$HOME/tpl";
      videos = "$HOME/vid";
    };
  };

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
        identityFile = "${ssh.dir}/gh-randomneet";
        addKeysToAgent = "yes";
      };
      "dix" = {
        hostname = "192.168.0.24";
        port = 22;
        user = "howl";
        identityFile = "${ssh.dir}/dix";
        addKeysToAgent = "yes";
      };
      "nasix" = {
        hostname = "192.168.0.56";
        port = 22;
        user = "howl";
        identityFile = "${ssh.dir}/nasix";
        addKeysToAgent = "yes";
      };
    };
    daemon = {
      enable = true;
      ports = [
        22
      ];
      authorizedKeysFiles = [ "${ssh.dir}/lix.pub" ];
      settings = {
        PasswordAuthentication = false;
      };
    };
    agent.enable = false;
  };

  gpg = {
    homedir = "/home/${username}/.gnupg";
    agent = {
      enable = true;
      enableSshSupport = true; # Automatically disable ssh-agent if set to true
    };
  };

  proxy = {
    method = "tproxy"; # tproxy lpf
    settingsFile = "/home/${username}/.vault/proxy/${proxy.method}/outsider/default.json";
  };

  zsh = {
    initContent = '''';

    envExtra = ''
      export VI_MODE_SET_CURSOR=true
      MODE_INDICATOR="%F{red}<<<%f"
    '';

    shellGlobalAliases = {
      G = "| grep";
    };
    shellAliases = {
      update = "sudo nixos-rebuild switch";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "vi-mode"
      ];
      theme = "simple";
    };
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
          name = "index";
          path = "~/${obsidian.vaults.default.target}/00 index";
          overrides = {
            notes_subdir = "00 index";
          };
        }
        {
          name = "study";
          path = "~/${obsidian.vaults.default.target}/10 study";
          overrides = {
            notes_subdir = "10 study";
          };
        }
        {
          name = "develop";
          path = "~/${obsidian.vaults.default.target}/20 develop";
          overrides = {
            notes_subdir = "20 develop";
          };
        }
        {
          name = "daily";
          path = "~/${obsidian.vaults.default.target}/30 daily";
          overrides = {
            notes_subdir = "30 daily";
          };
        }
        {
          name = "todos";
          path = "~/${obsidian.vaults.default.target}/99 todos";
          overrides = {
            notes_subdir = "99 todos";
          };
        }
      ];
    };
  };

  git = {
    userName = "RandomNEET";
    userEmail = "dev@randomneet.me";
  };

  wallpaper = {
    dir = "/home/${username}/pic/wallpapers";
    default = "${wallpaper.dir}/universal/black.png";
  };

  hyprland = {
    monitor = [
      "desc:Chimei Innolux Corporation 0x14C9, 1920x1080@60, 0x0, 1"
    ];
    workspaceBind = ''
      workspace = 1, monitor:desc:Chimei Innolux Corporation 0x14C9, default:true;
    '';
  };

  hyprlock = {
    monitor1 = "eDP-1";
    monitor2 = "";
    background1 = "${wallpaper.dir}/horizontal/mocha/greenbus.jpg";
  };

  hypridle = {
    time = {
      lock = "300";
      dpmsOff = "";
      suspend = "";
    };
  };

  obsidian = {
    vaults = {
      default = {
        enable = true;
        target = "doc/notes";
      };
    };
  };

  flatpak = {
    packages = {
      system = [ ];
      user = [
        "com.github.tchx84.Flatseal"
        "com.qq.QQ"
        "com.tencent.WeChat"
      ];
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
