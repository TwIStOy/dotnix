{
  config,
  lib,
  dotnix-utils,
  osConfig,
  ...
}: let
  cfg = config.dotnix.term.atuin;
in {
  options.dotnix.term.atuin = {
    enable = lib.mkEnableOption "Enable module dotnix.term.atuin";
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
