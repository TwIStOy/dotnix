{
  config,
  lib,
  pkgs-unstable,
  ...
}: let
  cfg = config.dotnix.apps.ollama;
in {
  options.dotnix.apps.ollama = {
    enable = lib.mkEnableOption "Enable module dotnix.apps.ollama";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs-unstable; [
      ollama
    ];
  };
}
