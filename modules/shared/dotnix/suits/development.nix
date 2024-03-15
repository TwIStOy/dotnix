{
  config,
  lib,
  dotnix-utils,
  ...
}: let
  inherit (dotnix-utils) enabled enableModules;
  cfg = config.dotnix.suits.development;
in {
  options.dotnix.suits.development = {
    enable = lib.mkEnableOption "Enable module dotnix.suits.development";
  };

  config = lib.mkIf cfg.enable {
    dotnix = {
      apps = enableModules [
        "atuin"
        "bat"
        "direnv"
      ];

      development = {
        build-tools = {
          enable = true;
          unstable = [
            "cmake"
          ];
        };
        languages = {
          all = enabled;
        };
      };
    };

    home-manager =
      dotnix-utils.hm.hmConfig {
      };
  };
}
