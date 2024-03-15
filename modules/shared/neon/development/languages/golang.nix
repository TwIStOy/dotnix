{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.neon.development.languages.golang;
in {
  options.neon.development.languages.golang = {
    enable = lib.mkEnableOption "Enable golang";
  };

  config = lib.mkIf cfg.enable {
    neon.hm.packages = with pkgs; [
      go
      gotools
      gopls
    ];
  };
}
