{
  config,
  pkgs,
  lib,
  dotnix-utils,
  ...
}: let
  cfg = config.dotnix.development.languages.%FILE%;
in {
  options.dotnix.development.languages.%FILE% = {
    enable = lib.mkEnableOption "Enable dev lang %FILE%";
  };

  config = lib.mkIf cfg.enable {
    dotnix.hm.packages = with pkgs; [
      %HERE%
    ];
    home-manager = dotnix-utils.hm.hmConfig {
    };
  };
}
