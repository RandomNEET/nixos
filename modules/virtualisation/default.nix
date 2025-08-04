{ pkgs, opts, ... }:
{
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = true;
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = [
            (pkgs.OVMF.override {
              secureBoot = true;
              tpmSupport = true;
            }).fd
          ];
        };
      };
    };
    spiceUSBRedirection.enable = true;
  };

  programs.virt-manager.enable = true;

  services = {
    qemuGuest.enable = true;
    spice-vdagentd.enable = true;
    spice-webdavd.enable = true;
  };

  environment.systemPackages = with pkgs; [
    virt-viewer
    spice
    spice-gtk
    spice-protocol
    spice-vdagent
    win-virtio
    win-spice
  ];

  users = {
    users = {
      ${opts.username} = {
        extraGroups = [ "libvirtd" ];
      };
    };
  };
}
