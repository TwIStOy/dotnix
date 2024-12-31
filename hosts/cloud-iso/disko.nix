_: {
  disko = {
    enableConfig = true;

    devices = {
      disk.main = {
        imageSize = "20G";
        device = "/dev/vda";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            grub = {
              size = "1M";
              type = "EF02";
              priority = 0;
            };

            boot = {
              name = "boot";
              size = "512M";
              type = "EF00";
              priority = 1;
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = ["fmask=0077" "dmask=0077"];
              };
            };

            nixos = {
              name = "nixos";
              size = "100%";
              content = {
                type = "filesystem";
                format = "btrfs";
                mountpoint = "/";
                mountOptions = ["compress-force=zstd" "nosuid" "nodev"];
              };
            };
          };
        };
      };
    };
  };

  # fileSystems."/" = {
  #   device = "/dev/disk/by-label/nixos";
  #   fsType = "btrfs";
  #   options = ["compress-force=zstd" "nosuid" "nodev"];
  # };
  #
  # fileSystems."/boot" = {
  #   device = "/dev/disk/by-label/boot";
  #   fsType = "vfat";
  #   options = ["fmask=0077" "dmask=0077"];
  # };
}
