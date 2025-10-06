{
  config,
  pkgs-unstable,
  lib,
  dotnix-utils,
  ...
}: let
  cfg = config.dotnix.development.languages.zig;
in {
  options.dotnix.development.languages.zig = {
    enable = lib.mkEnableOption "Enable dev lang zig";
  };

  config = lib.mkIf cfg.enable {
    dotnix.hm.packages = with pkgs-unstable; [
      zig
      zls
    ];
    home-manager =
      dotnix-utils.hm.hmConfig {
      };
  };
}
