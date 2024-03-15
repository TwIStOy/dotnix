{
  config,
  lib,
  dotnix-utils,
  nur-hawtian,
  pkgs,
  ...
}: let
  cfg = config.dotnix.apps.rime_ls;
in {
  options.dotnix.apps.rime_ls = {
    enable = lib.mkEnableOption "Enable module dotnix.apps.rime_ls";
  };

  config = lib.mkIf cfg.enable {
    home-manager = dotnix-utils.hm.hmConfig {
      home.packages = [
        nur-hawtian.packages.${pkgs.system}.rime-ls
      ];

      xdg.dataFile.rime-ls-files = {
        source = ./files;
        recursive = true;
        force = true;
      };
    };
  };
}
