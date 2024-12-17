_: let
  hostname = "taihou";
in {
  # Bootloader.
  boot = {
    loader = {
      grub = {
        enable = true;
        device = "/dev/nvme0n1";
        useOSProber = true;
      };
    };
  };

  networking = {
    hostName = hostname;
    networkmanager.enable = true;
    proxy.default = "http://192.168.50.217:8888";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  system.stateVersion = "24.11";
}
