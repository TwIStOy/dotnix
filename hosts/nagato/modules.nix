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
        map-nerdfont-ranges = false;
      };

      neovide.createRemoteHostWrappers = [
        "dev.work.local"
      ];

      ghostty.only-connect-dev-server = "dev.work.local.tmux";
    };

    apps.zed = {
      buffer_font_size = 18;
      ui_font_size = 16;
      ssh_connections = [
        {
          host = "dev.work.local";
          projects = [
          ];
        }
      ];
    };

    services.tailscale = {
      enable = true;
      extraUpFlags = [
        "--advertise-tags=tag:desktop"
        "--accept-routes"
      ];
    };
  };

  networking.hostName = hostname;
  networking.computerName = hostname;

  system.defaults.smb.NetBIOSName = hostname;
  system.stateVersion = 5;
}
