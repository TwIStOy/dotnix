{
  config,
  lib,
  dotnix-utils,
  ...
}: let
  cfg = config.dotnix.darwin-shared-suit;
  inherit (dotnix-utils) enabled;
in {
  options.dotnix.darwin-shared-suit = {
    enable = lib.mkEnableOption "Enable shared-suit for all darwin hosts.";
  };

  config = lib.mkIf cfg.enable {
    dotnix.shared-suit = enabled;

    dotnix.apps.yabai = enabled;
  };
}
