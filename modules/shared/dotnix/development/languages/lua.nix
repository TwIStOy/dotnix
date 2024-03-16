{
  config,
  pkgs,
  lib,
  dotnix-utils,
  ...
}: let
  cfg = config.dotnix.development.languages.lua;
in {
  options.dotnix.development.languages.lua = {
    enable = lib.mkEnableOption "Enable dev lang lua";
  };

  config = lib.mkIf cfg.enable {
    dotnix.hm.packages = with pkgs; [
      luajit
      stylua
      lua-language-server
    ];
    home-manager =
      dotnix-utils.hm.hmConfig {
      };
  };
}
