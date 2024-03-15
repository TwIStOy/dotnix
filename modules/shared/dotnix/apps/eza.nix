{
  config,
  lib,
  dotnix-utils,
  ...
}: let
  cfg = config.dotnix.apps.eza;
in {
  options.dotnix.apps.eza = {
    enable = lib.mkEnableOption "Enable module dotnix.apps.eza";
  };

  config = lib.mkIf cfg.enable {
    home-manager = dotnix-utils.hm.hmConfig {
      programs.eza = {
        enable = true;
        git = true;
        icons = true;
        extraOptions = ["--header"];
      };
    };
  };
}
