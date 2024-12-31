{
  config,
  lib,
  ...
}: {
  imports = [
    # inputs.disko.nixosModules.disko
  ];

  boot = {
    kernelParams = [
      "audit=0"
      "net.ifnames=0"
    ];

    initrd = {
      compressor = "zstd";
      compressorArgs = ["-19" "-T0"];
      systemd.enable = true;
    };

    loader.systemd-boot.enable = true;
    loader.grub = {
      default = "saved";
      devices = ["/dev/vda"];
    };
  };

  users.mutableUsers = false;
  users.users.root = {
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG92SyvgOOe9pGPGHEY9VbDBWwqaRgm9tg1RJUxlfdCN MainSSH"
    ];
  };

  systemd.network.enable = true;
  services.resolved.enable = false;

  services.openssh.settings.PermitRootLogin = lib.mkForce "prohibit-password";

  networking = {
    firewall.enable = false;
    useDHCP = false;

    hostName = "bootstrap";
  };

  system.stateVersion = "24.11";

  boot.initrd.availableKernelModules = [
    "virtio_net"
    "virtio_pci"
    "virtio_mmio"
    "virtio_blk"
    "virtio_scsi"
  ];
  boot.initrd.kernelModules = [
    "virtio_balloon"
    "virtio_console"
    "virtio_rng"
  ];
}
