rec {
  # General
  hostname = "nasix";
  system = "x86_64-linux";

  # Users
  rootpasswd = "$6$1bNtqKFsObhMC1OG$THnog0HqmR/GnN.0IwndZzuijVMiV0cZIPUjmCvDs6gsjHAc.FYfcIlKmiMx2hy2gbd814Br1uNAhiyKl4W9g.";
  username = "howl";
  userpasswd = "$6$.FVrKngH1eXjNYi9$lsTAUQvvJyB209fhkf3g5E12iCcgNdDZKW0XTwCp7i3lNwM8gjNq3kRgjW4WIBV68YETysoDCHhKtSIncPT3n1";
  uid = 1000;

  # User environment
  editor = "nvim";
  terminal = "";
  terminalFileManager = "yazi";
  browser = "";
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
    enable = false;
    lanzaboote = {
      enable = false;
      pkiBundle = "";
    };
  };

  # Services
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

  mpd = {
    startWhenNeeded = false;
    musicDirectory = "/mnt/smb/media/music";
    dataDir = "/mnt/smb/media/.mpd";
    extraConfig = ''
      bind_to_address "0.0.0.0"
      port "6600"
      audio_output {
          type        "httpd"
          name        "MPD HTTP Stream"
          encoder     "vorbis"
          port        "8000"
          quality     "5.0"
      }
    '';
    audioType = "httpd";
  };

  proxy = {
    method = "lpf"; # tproxy lpf
    settingsFile = "/home/${username}/.vault/proxy/${proxy.method}/motherly-outside/docker.json";
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

  ssh = {
    dir = "/home/${username}/.vault/ssh";
    matchBlocks = {
      "dix" = {
        hostname = "192.168.0.24";
        port = 22;
        user = "howl";
        identityFile = "${ssh.dir}/dix";
        addKeysToAgent = "yes";
      };
      "lix" = {
        hostname = "192.168.0.69";
        port = 22;
        user = "howl";
        identityFile = "${ssh.dir}/lix";
        addKeysToAgent = "yes";
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

  # Programs
  git = {
    userName = "RandomNEET";
    userEmail = "dev@randomneet.me";
  };

  nixvim = {
    withNodeJs = false;
    withPerl = false;
    withPython3 = true;
    withRuby = false;

    lsp.enable = false;
    treesitter.enable = false; # Automatically disable noice if set to false
    lint.enable = false;
    conform.enable = false;
    copilot.enable = false;
    noice.enable = false; # Require treesitter
    snack = {
      image.enable = false;
    };
  };

  zsh = {
    initContent = ''
      export EDITOR=${editor}
    '';

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
    };
  };
}
