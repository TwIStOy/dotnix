{
  config,
  lib,
  dotnix-utils,
  ...
}: let
  cfg = config.dotnix.apps.ssh;
in {
  options.dotnix.apps.ssh = {
    enable = lib.mkEnableOption "Enable module dotnix.apps.ssh";
  };

  config = lib.mkIf cfg.enable {
    home-manager = dotnix-utils.hm.hmModule ./home.nix;
  };
}
