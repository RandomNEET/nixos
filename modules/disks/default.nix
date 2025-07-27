{ ... }:
{
  boot.supportedFilesystems = [
    "ntfs"
    "exfat"
    "ext4"
    "fat32"
    "btrfs"
  ];
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
}
