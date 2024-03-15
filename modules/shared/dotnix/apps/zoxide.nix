{
  config,
  lib,
  dotnix-utils,
  ...
}: let
  cfg = config.dotnix.apps.zoxide;
in {
  options.dotnix.apps.zoxide = {
    enable = lib.mkEnableOption "Enable module dotnix.apps.zoxide";
  };

  config = lib.mkIf cfg.enable {
    home-manager = dotnix-utils.hm.hmConfig {
      programs.zoxide = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
        enableFishIntegration = true;
      };
    };
  };
}
