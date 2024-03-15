{
  config,
  lib,
  dotnix-utils,
  ...
}: let
  cfg = config.dotnix.apps.lazygit;
in {
  options.dotnix.apps.lazygit = {
    enable = lib.mkEnableOption "Enable module dotnix.apps.lazygit";
  };

  config = lib.mkIf cfg.enable {
    home-manager = dotnix-utils.hm.hmConfig {
      programs.lazygit = {
        enable = true;
        settings = {
          gui = {
            mouseEvents = true;
            nerdFontsVersion = "3";
            border = "single";
          };
          notARepository = "skip";
          git = {
            parseEmoji = true;
          };
        };
      };
    };
  };
}
