{dotnix-utils, ...}: let
  inherit (dotnix-utils) enabled;
  hostname = "yukikaze";
in {
  dotnix.darwin-shared-suit = enabled;

  dotnix.desktop.neovide.extraSettings.font.size = 18;

  networking.hostName = hostname;
  networking.computerName = hostname;
  system.defaults.smb.NetBIOSName = hostname;
}
