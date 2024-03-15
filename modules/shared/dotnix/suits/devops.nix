{
  config,
  lib,
  pkgs,
  dotnix-utils,
  ...
}: let
  cfg = config.dotnix.suits.devops;
in {
  options.dotnix.suits.devops = {
    enable = lib.mkEnableOption "Enable module dotnix.suits.devops";
  };

  config = lib.mkIf cfg.enable {
    home-manager = dotnix-utils.hm.hmConfig {
      home.packages = with pkgs; [
        ansible

        lazydocker # docker TUI
        dive # explore layers in docker images
      ];
    };
  };
}
