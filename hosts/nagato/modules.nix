{dotnix-utils, ...}: let
  inherit (dotnix-utils) enabled;
  hostname = "nagato";
in {
  dotnix = {
    darwin-shared-suit = enabled;
    desktop = {
      neovide.extraSettings.font.size = 18;
      terminal = {
        font-size = 18;
        font-family = "Maple Mono NF CN";
        font-variants = builtins.map (variant: "MapleMono-NF-CN-${variant}") [
          "Bold"
          "BoldItalic"
          "ExtraBold"
          "ExtraBoldItalic"
          "ExtraLight"
          "ExtraLightItalic"
          "Italic"
          "Light"
          "LightItalic"
          "Medium"
          "MediumItalic"
          "Regular"
          "SemiBold"
          "SemiBoldItalic"
          "Thin"
          "ThinItalic"
        ];
        font-features = ["+ss01" "+ss02"];
      };

      neovide.createRemoteHostWrappers = [
        "dev.work.local"
      ];
    };

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
