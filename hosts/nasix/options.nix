rec {
  hostname = "nasix";
  system = "x86_64-linux";
  role = "server";

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

  # https://github.com/nix-community/lanzaboote/blob/master/docs/QUICK_START.md
  secure-boot = {
    enable = false;
    lanzaboote = {
      enable = false;
      pkiBundle = "";
    };
  };

  snapper = {
    config = { };
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
    homedir = "/home/${username}/.vault/gpg";
    agent = {
      enable = true;
      enableSshSupport = false; # Automatically disable ssh-agent if set to true
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

  nixvim = {
    lsp.enable = false;
    treesitter.enable = false; # Automatically disable noice if set to false
    lint.enable = false;
    conform.enable = false;
    copilot.enable = false;
    noice.enable = false; # Require treesitter
    snack = {
      image.enable = false;
    };
    obsidian = {
      workspaces = [ ];
    };
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
      default = {
        enable = false;
        target = "";
      };
    };
  };

  samba = {
    settings = {
      global = {
        "invalid users" = [
          "root"
        ];
        "passwd program" = "/run/wrappers/bin/passwd %u";
        security = "user";
      };
      private = {
        browseable = "yes";
        comment = "Private samba share.";
        path = "/mnt/smb";
        "valid users" = [ "${username}" ];
        "read only" = "no";
        "writable" = "yes";
      };
    };
  };

  frp = {
    role = "client"; # server client
    settings = {
      serverAddr = "144.168.60.188";
      serverPort = 20000;
      auth.token = "hVuywt2SYnpUyEdUixinVNOHbODjJDfm2K6kxnz9WRroa515j2RAqtaP6RUhXIOPMyq9Sopq0avgb4w9VxPJd3PWbBqKcB2AtYmwPc2A0KDgsc78IjLzHqoOHL";
      transport.tls.trustedCaFile = "/etc/frp/cert/ca.crt";
      transport.tls.certFile = "/etc/frp/cert/client.crt";
      transport.tls.keyFile = "/etc/frp/cert/client.key";

      proxies = [
        {
          name = "jellyfin";
          type = "tcp";
          localIP = "127.0.0.1";
          localPort = 8096;
          remotePort = 8096;
        }
        {
          name = "homepage";
          type = "tcp";
          localIP = "127.0.0.1";
          localPort = 10000;
          remotePort = 10000;
        }
        {
          name = "calibre";
          type = "tcp";
          localIP = "127.0.0.1";
          localPort = 10100;
          remotePort = 10100;
        }
        {
          name = "freshrss";
          type = "tcp";
          localIP = "127.0.0.1";
          localPort = 10110;
          remotePort = 10110;
        }
        {
          name = "rsshub";
          type = "tcp";
          localIP = "127.0.0.1";
          localPort = 10120;
          remotePort = 10120;
        }
        {
          name = "qbittorrent";
          type = "tcp";
          localIP = "127.0.0.1";
          localPort = 10200;
          remotePort = 10200;
        }
        {
          name = "peerbanhelper";
          type = "tcp";
          localIP = "127.0.0.1";
          localPort = 10225;
          remotePort = 10225;
        }
        {
          name = "anirss";
          type = "tcp";
          localIP = "127.0.0.1";
          localPort = 10230;
          remotePort = 10230;
        }
        {
          name = "autobangumi";
          type = "tcp";
          localIP = "127.0.0.1";
          localPort = 10240;
          remotePort = 10240;
        }
        {
          name = "moviepilot";
          type = "tcp";
          localIP = "127.0.0.1";
          localPort = 10250;
          remotePort = 10250;
        }
        {
          name = "vaultwarden";
          type = "tcp";
          localIP = "127.0.0.1";
          localPort = 10300;
          remotePort = 10300;
        }
        {
          name = "linkding";
          type = "tcp";
          localIP = "127.0.0.1";
          localPort = 10310;
          remotePort = 10310;
        }
        {
          name = "notemark";
          type = "tcp";
          localIP = "127.0.0.1";
          localPort = 10320;
          remotePort = 10320;
        }
        {
          name = "drawio";
          type = "tcp";
          localIP = "127.0.0.1";
          localPort = 10330;
          remotePort = 10330;
        }
        {
          name = "obsidian-livesync";
          type = "tcp";
          localIP = "127.0.0.1";
          localPort = 10340;
          remotePort = 10340;
        }
        {
          name = "speedtest";
          type = "tcp";
          localIP = "127.0.0.1";
          localPort = 10400;
          remotePort = 10400;
        }
        {
          name = "glances";
          type = "tcp";
          localIP = "127.0.0.1";
          localPort = 61208;
          remotePort = 61208;
        }
      ];
    };
  };
}
