{
  config,
  pkgs-unstable,
  lib,
  dotnix-utils,
  ...
}: let
  cfg = config.dotnix.development.languages.java;
in {
  options.dotnix.development.languages.java = {
    enable = lib.mkEnableOption "Enable dev lang java";
  };

  config = lib.mkIf cfg.enable {
    dotnix.hm.packages = with pkgs-unstable; [
      jdt-language-server
      jdk
    ];
    home-manager =
      dotnix-utils.hm.hmConfig {
      };
  };
}
