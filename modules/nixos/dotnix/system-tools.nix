{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dotnix.system-tools;
in {
  options.dotnix.system-tools = {
    enable = lib.mkEnableOption "Enable module dotnix.system-tools";
  };

  config = lib.mkIf cfg.enable {
    dotnix.hm.packages = with pkgs; [
      gdb

      strace
      ltrace
      bpftrace
      tcpdump
      lsof
      socat

      pciutils
      usbutils

      iotop
      iftop
      tcpdump
    ];
  };
}
