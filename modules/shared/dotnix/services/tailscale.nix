{
  pkgs,
  pkgs-unstable,
  config,
  lib,
  ...
}: let
  cfg = config.dotnix.services.tailscale;
in {
  options.dotnix.services.tailscale = {
    enable = lib.mkEnableOption "Enable module dotnix.services.tailscale";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs-unstable; [
      tailscale
    ];
    services.tailscale = {
      enable = true;
    };
  };
}
