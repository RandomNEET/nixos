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
          "wheel"
          "networkmanager"
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

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?
}
