{
  config,
  lib,
  dotnix-utils,
  osConfig,
  ...
}: let
  cfg = config.dotnix.apps.atuin;
in {
  options.dotnix.apps.atuin = {
    enable = lib.mkEnableOption "Enable module dotnix.apps.atuin";
  };

  config = lib.mkIf cfg.enable {
    home-manager = dotnix-utils.hm.hmConfig {
      programs.atuin = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
        enableFishIntegration = true;
      };

      xdg.configFile."atuin/config.toml" = {
        source = lib.file.mkOutOfStoreSymlink "${osConfig.age.secrets.atuin-client-config.path}";
        force = true;
      };
    };
  };
}
