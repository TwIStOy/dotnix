{dotnix-utils, ...}: let
  inherit (dotnix-utils) enabled;
  hostname = "yamato";
in {
  dotnix = {
    darwin-shared-suit = enabled;

    desktop.neovide.extraSettings.font.size = 22;
    apps.zed.buffer_font_size = 22;
  };

  networking.hostName = hostname;
  networking.computerName = hostname;
  system.defaults.smb.NetBIOSName = hostname;

  system.stateVersion = 5;
}
