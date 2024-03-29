{
  config,
  lib,
  dotnix-utils,
  pkgs,
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
        "gh"
        "git"
        "lazygit"
        "difftastic"
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

      hm.packages = with pkgs; [
        rsync
        # man pages
        man-pages
      ];
    };

    home-manager =
      dotnix-utils.hm.hmConfig {
      };
  };
}
