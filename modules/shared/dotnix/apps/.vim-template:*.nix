{
  config,
  lib,
  dotnix-utils,
  ...
}: let
  cfg = config.dotnix.apps.%FILE%;
in {
  options.dotnix.apps.%FILE% = {
    enable = lib.mkEnableOption "Enable module dotnix.apps.%FILE%";
  };

  config = lib.mkIf cfg.enable {
    home-manager = dotnix-utils.hm.hmConfig {
      %HERE%
    };
  };
}
