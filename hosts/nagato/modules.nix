{dotnix-utils, ...}: let
  inherit (dotnix-utils) enabled;
  hostname = "nagato";
in {
  dotnix = {
    darwin-shared-suit = enabled;

    desktop.neovide.extraSettings.font.size = 18;
    apps.zed.buffer_font_size = 18;
    apps.zed.ui_font_size = 16;

    services.tailscale = {
      enable = true;
      extraUpFlags = [
        "--advertise-tags=tag:desktop"
      ];
    };
  };

  networking.hostName = hostname;
  networking.computerName = hostname;

  system.defaults.smb.NetBIOSName = hostname;
  system.stateVersion = 5;
}
