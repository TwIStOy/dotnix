{
  config,
  pkgs-unstable,
  lib,
  ...
}: let
  cfg = config.dotnix.development.languages.markdown;
in {
  options.dotnix.development.languages.markdown = {
    enable = lib.mkEnableOption "Enable dev lang markdown";
  };

  config = lib.mkIf cfg.enable {
    dotnix.hm.packages = with pkgs-unstable; [
      glow
    ];
  };
}
