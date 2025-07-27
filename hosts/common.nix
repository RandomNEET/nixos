{
  inputs,
  pkgs,
  lib,
  opts,
  ...
}:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  networking.hostName = opts.hostname; # Define your hostname.

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Bootloader.
  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
  };

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = opts.timezone;

  # Select internationalisation properties.
  i18n.defaultLocale = opts.locale;

  i18n.extraLocaleSettings = {
    LC_ADDRESS = opts.locale;
    LC_IDENTIFICATION = opts.locale;
    LC_MEASUREMENT = opts.locale;
    LC_MONETARY = opts.locale;
    LC_NAME = opts.locale;
    LC_NUMERIC = opts.locale;
    LC_PAPER = opts.locale;
    LC_TELEPHONE = opts.locale;
    LC_TIME = opts.locale;
  };

  console.keyMap = opts.consoleKeymap; # Configure console keymap

  # Packages in system profile
  environment.systemPackages = with pkgs; [ ];

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    mutableUsers = false;
    users = {
      root.initialHashedPassword = opts.rootpasswd;
      ${opts.username} = {
        initialHashedPassword = opts.userpasswd;
        isNormalUser = true;
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
      };
    };
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    users.howl =
      { config, pkgs, ... }:
      {
        # Let Home Manager install and manage itself.
        programs.home-manager.enable = true;

        home.username = opts.username;
        home.homeDirectory = "/home/${opts.username}";
        home.stateVersion = "25.05"; # Please read the comment before changing.

        # Packages that don't require configuration. If you're looking to configure a program see the /modules dir
        home.packages = with pkgs; [ ];

        # XDG user dirs config
        xdg = {
          userDirs = {
            enable = true;
            createDirectories = false;
            desktop = "${config.home.homeDirectory}/dsk";
            documents = "${config.home.homeDirectory}/doc";
            download = "${config.home.homeDirectory}/dls";
            music = "${config.home.homeDirectory}/mus";
            pictures = "${config.home.homeDirectory}/pic";
            publicShare = "${config.home.homeDirectory}/pub";
            templates = "${config.home.homeDirectory}/tpl";
            videos = "${config.home.homeDirectory}/vid";
          };
        };
      };
  };

  environment.sessionVariables = {
    # These are the defaults, and xdg.enable does set them, but due to load
    # order, they're not set before environment.variables are set, which could
    # cause race conditions.
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_BIN_HOME = "$HOME/.local/bin";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
