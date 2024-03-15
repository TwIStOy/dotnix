{
  config,
  lib,
  dotnix-utils,
  ...
}: let
  cfg = config.dotnix.apps.direnv;
in {
  options.dotnix.apps.direnv = {
    enable = lib.mkEnableOption "Enable module dotnix.apps.direnv";
  };

  config = lib.mkIf cfg.enable {
    home-manager = dotnix-utils.hm.hmConfig {
      programs = {
        direnv = {
          enable = true;
          nix-direnv.enable = true;

          enableBashIntegration = true;
          enableZshIntegration = true;
        };
      };
    };
  };
}
