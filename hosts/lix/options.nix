rec {
  # System
  hostname = "lix";
  system = "x86_64-linux";
  gpu = "intel-integrated";
  locale = "en_US.UTF-8";
  timezone = "Asia/Shanghai";
  kbdLayout = "us";
  consoleKeymap = "us";
  boot = {
    kernelPackages = "linuxPackages_zen"; # _latest, _zen, _xanmod_latest, _hardened, _rt, _OTHER_CHANNEL, etc.
  };
  lanzaboote = {
    enable = true;
    pkiBundle = "/nix/persist/var/lib/sbctl";
  };
  firewall = {
    enable = true;
    allowedTCPPorts = [ ];
    allowedUDPPorts = [ ];
  };

  # Users
  rootpasswd = "$6$1bNtqKFsObhMC1OG$THnog0HqmR/GnN.0IwndZzuijVMiV0cZIPUjmCvDs6gsjHAc.FYfcIlKmiMx2hy2gbd814Br1uNAhiyKl4W9g.";
  username = "howl";
  userpasswd = "$6$.FVrKngH1eXjNYi9$lsTAUQvvJyB209fhkf3g5E12iCcgNdDZKW0XTwCp7i3lNwM8gjNq3kRgjW4WIBV68YETysoDCHhKtSIncPT3n1";
  uid = 1000;

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
        command = "tuigreet --time --theme 'border=lightblue;text=white;prompt=lightcyan;time=lightyellow;action=white;button=lightred;container=black;input=white' --cmd niri-session";
        # command = "tuigreet --time --theme 'border=lightblue;text=white;prompt=lightcyan;time=lightyellow;action=white;button=lightred;container=black;input=white' --cmd hyprland";
        user = "greeter";
      };
    };
  };

  mpd = {
    dataDir = "/home/${username}/.local/share/mpd";
    musicDirectory = "/home/${username}/mus";
    startWhenNeeded = true;
    extraConfig = ''
      audio_output {
         type   "pipewire"
         name   "PipeWire Sound Server"
      }
      audio_output {
         type   "fifo"
         name   "my_fifo"
         path   "/tmp/mpd.fifo"
         format "44100:16:2"
      }
      auto_update "yes"
    '';
    outputType = "pipewire";
  };

  ssh = {
    keysDir = "/home/${username}/.vault/ssh";

    daemon = {
      enable = true;
      ports = [
        22
      ];
      settings = {
        PasswordAuthentication = false;
      };
      authorizedKeysFiles = [ "${ssh.keysDir}/lix.pub" ];
    };

    client = {
      matchBlocks = {
        "github.com" = {
          hostname = "github.com";
          user = "git";
          identityFile = "${ssh.keysDir}/gh-randomneet";
          addKeysToAgent = "yes";
        };
        "dix" = {
          hostname = "192.168.0.24";
          port = 22;
          user = "howl";
          identityFile = "${ssh.keysDir}/dix";
          addKeysToAgent = "yes";
        };
        "nasix" = {
          hostname = "192.168.0.56";
          port = 22;
          user = "howl";
          identityFile = "${ssh.keysDir}/nasix";
          addKeysToAgent = "yes";
        };
      };
      agent.enable = false;
    };
  };

  tlp = {
    settings = {
      START_CHARGE_THRESH_BAT0 = 40;
      STOP_CHARGE_THRESH_BAT0 = 80;
      START_CHARGE_THRESH_BAT1 = 40;
      STOP_CHARGE_THRESH_BAT1 = 80;
    };
  };

  proxy = {
    dae = {
      configFile = "/home/${username}/.vault/proxy/dae/default.dae";
      openFirewall = {
        enable = true;
        port = 12345;
      };
    };
  };

  # Programs
  git = {
    user = {
      name = "RandomNEET";
      email = "dev@randomneet.me";
    };
  };

  gpg = {
    homedir = "/home/${username}/.gnupg";
    agent = {
      enable = true;
      enableSshSupport = true; # Automatically disable ssh-agent if set to true
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
    copilot = {
      enable = true;
      cmp = false;
    };
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

  rbw = {
    settings = {
      base_url = "https://vaultwarden.scaphium.xyz";
      email = "selfhost@randomneet.me";
      lock_timeout = 3600;
    };
    rofi-rbw = true;
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

  firefox = {
    network.trr = {
      mode = 3; # 0 - Off (default), 1 - Reserved, 2 - First, 3 - Only
      uri = "https://dns.alidns.com/dns-query";
      custom_uri = "https://dns.alidns.com/dns-query";
    };
    browser.startup.homepage = "https://startpage.randomneet.me/";
    DisableFirefoxAccounts = false;
    titlebar-buttons-disable = true;
    full-screen-api.ignore-widgets = true;
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
  display = [
    {
      output = "eDP-1";
      width = 1920;
      height = 1080;
      orientation = "landscape";
    }
  ];

  hibernate = true;

  wallpaper = {
    dir = "/home/${username}/pic/wallpapers";
    landscapeDir = "${wallpaper.dir}/landscape";
    portraitDir = "${wallpaper.dir}/portrait";
    transition = {
      type = "center";
      step = 90;
      duration = 1;
      fps = 60;
    };
  };

  hyprland = {
    monitor = [
      "desc:Chimei Innolux Corporation 0x14C9, 1920x1080@60, 0x0, 1"
    ];
    workspaceBind = ''
      workspace = 1, monitor:desc:Chimei Innolux Corporation 0x14C9, default:true;
    '';
  };

  hypridle = {
    time = {
      lock = "300";
      dpmsOff = "1800";
      sleep = "3600";
    };
  };

  hyprlock = {
    background = "${wallpaper.dir}/landscape/touhou/marisa-reimu-3.jpg";
  };

  niri = {
    output = [
      {
        off = false;
        name = "eDP-1";
        mode = "1920x1080@60.008";
        scale = 1.25;
        transform = "normal";
        position = {
          x = 0;
          y = 0;
        };
        variable-refresh-rate = false;
        focus-at-startup = true;
      }
    ];
  };

  swayidle = {
    time = {
      lock = 300;
      dpmsOff = 1800;
      sleep = 3600;
    };
  };

  swaylock = {
    image = "eDP-1:${wallpaper.dir}/landscape/touhou/marisa-reimu-3.jpg";
  };
}
