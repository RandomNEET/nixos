rec {
  # General
  hostname = "dix";
  system = "x86_64-linux";

  # Users
  rootpasswd = "$6$1bNtqKFsObhMC1OG$THnog0HqmR/GnN.0IwndZzuijVMiV0cZIPUjmCvDs6gsjHAc.FYfcIlKmiMx2hy2gbd814Br1uNAhiyKl4W9g.";
  username = "howl";
  userpasswd = "$6$.FVrKngH1eXjNYi9$lsTAUQvvJyB209fhkf3g5E12iCcgNdDZKW0XTwCp7i3lNwM8gjNq3kRgjW4WIBV68YETysoDCHhKtSIncPT3n1";

  # User environment
  editor = "nvim";
  terminal = "kitty";
  terminalFileManager = "yazi";
  browser = "firefox";
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

  # System
  gpu = "nvidia";
  locale = "en_US.UTF-8";
  timezone = "Asia/Shanghai";
  kbdLayout = "us";
  kbdVariant = "";
  consoleKeymap = "us";
  hibernate = false;

  secure-boot = {
    enable = true;
    lanzaboote = {
      enable = true;
      pkiBundle = "/nix/persist/var/lib/sbctl";
    };
  };

  # Services
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

  greetd = {
    settings = {
      default_session = {
        command = "tuigreet --time --theme 'border=lightblue;text=white;prompt=lightcyan;time=lightyellow;action=white;button=lightred;container=black;input=white' --cmd hyprland";
        user = "greeter";
      };
    };
  };

  proxy = {
    method = "tproxy"; # tproxy lpf
    settingsFile = "/home/${username}/.vault/proxy/${proxy.method}/outsider/default.json";
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
      "lix" = {
        hostname = "192.168.0.69";
        port = 22;
        user = "howl";
        identityFile = "${ssh.dir}/lix";
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
      authorizedKeysFiles = [ "${ssh.dir}/dix.pub" ];
      settings = {
        PasswordAuthentication = false;
      };
    };
    agent.enable = false;
  };

  # Programs
  git = {
    userName = "RandomNEET";
    userEmail = "dev@randomneet.me";
  };

  gpg = {
    homedir = "/home/${username}/.gnupg";
    agent = {
      enable = true;
      enableSshSupport = true; # Automatically disable ssh-agent if set to true
    };
  };

  ncmpcpp = {
    settings = {
      mpd_host = "192.168.0.56";
      mpd_port = "6600";
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

  obsidian = {
    vaults = {
      default = {
        enable = true;
        target = "doc/notes";
      };
    };
  };

  # Desktop
  display = {
    width = 3840;
    height = 2160;
  };

  wallpaper = {
    dir = "/home/${username}/pic/wallpapers";
    default = "${wallpaper.dir}/universal/black.png";
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
    background2 = "${wallpaper.dir}/vertical/anime/reimu-city.jpg";
  };

  hypridle = {
    time = {
      lock = "1800";
      dpmsOff = "3600";
      sleep = "";
    };
  };
}
