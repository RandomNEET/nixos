{
  inputs,
  config,
  pkgs,
  ...
}:
{
  # persist
  imports = [ inputs.impermanence.nixosModules.impermanence ];
  environment.persistence."/nix/persist" = {
    hideMounts = true;
    directories = [
      # "/var/log"
      "/var/lib/nixos"
      "/var/lib/systemd/coredump"
      "/var/lib/systemd/timers"
      "/var/lib/bluetooth"
      "/etc/NetworkManager/system-connections"
      {
        directory = "/var/lib/colord";
        user = "colord";
        group = "colord";
        mode = "u=rwx,g=rx,o=";
      }
    ] ++ (if config.virtualisation.libvirtd.enable then [ "/var/lib/libvirt" ] else [ ]);
    files =
      [
        "/etc/machine-id"
        {
          file = "/etc/nix/id_rsa";
          parentDirectory = {
            mode = "u=rwx,g=rx,o=rx";
          };
        }
      ]
      ++ (
        if config.services.openssh.enable then
          [
            "/etc/ssh/ssh_host_rsa_key"
            "/etc/ssh/ssh_host_rsa_key.pub"
            "/etc/ssh/ssh_host_ed25519_key"
            "/etc/ssh/ssh_host_ed25519_key.pub"
          ]
        else
          [ ]
      );
  };
  security.sudo.extraConfig = ''
    Defaults lecture = never
  '';
}
