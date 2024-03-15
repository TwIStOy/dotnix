{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.dotnix.development.languages.golang;
in {
  options.dotnix.development.languages.golang = {
    enable = lib.mkEnableOption "Enable golang";
  };

  config = lib.mkIf cfg.enable {
    dotnix.hm.packages = with pkgs; [
      go
      gotools
      gopls
    ];
  };
}
