{
  config,
  lib,
  dotnix-utils,
  ...
}: let
  cfg = config.dotnix.shared-suit;
  inherit (dotnix-utils) enabled;
in {
  options.dotnix.shared-suit = {
    enable = lib.mkEnableOption "Enable shared-suit for all hosts.";
  };

  config = lib.mkIf cfg.enable {
    dotnix.suits = {
      desktop = enabled;
      development = enabled;
      devops = enabled;
      term = enabled;
    };
  };
}
