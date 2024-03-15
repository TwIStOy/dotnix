{
  config,
  lib,
  dotnix-utils,
  ...
}: let
  cfg = config.dotnix.apps.gh;
in {
  options.dotnix.apps.gh = {
    enable = lib.mkEnableOption "Enable module dotnix.apps.gh";
  };

  config = lib.mkIf cfg.enable {
    home-manager = dotnix-utils.hm.hmConfig {
      programs.gh = {
        enable = true;

        settings = {
          editor = "nvim";
        };
      };
    };
  };
}
