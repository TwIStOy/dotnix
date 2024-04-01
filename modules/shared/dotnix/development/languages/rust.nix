{
  config,
  pkgs-unstable,
  lib,
  dotnix-utils,
  ...
}: let
  cfg = config.dotnix.development.languages.rust;
in {
  options.dotnix.development.languages.rust = {
    enable = lib.mkEnableOption "Enable dev lang rust";
  };

  config = lib.mkIf cfg.enable {
    dotnix.hm.packages = with pkgs-unstable; [
      rust-analyzer
      cargo
      rustc
      rustfmt
    ];
    home-manager =
      dotnix-utils.hm.hmConfig {
      };
  };
}
