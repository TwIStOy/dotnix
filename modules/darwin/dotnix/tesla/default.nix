{
  config,
  lib,
  dotnix-utils,
  ...
}: let
  cfg = config.dotnix.tesla;
in {
  options.dotnix.tesla = {
    enable = lib.mkEnableOption "Enable module dotnix.tesla";
  };

  config =
    lib.mkIf cfg.enable {
    };
}
