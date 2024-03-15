{
  config,
  lib,
  dotnix-utils,
  ...
}: let
  cfg = config.dotnix.apps.atuin;
in {
  options.dotnix.apps.atuin = {
    enable = lib.mkEnableOption "Enable module dotnix.apps.atuin";
  };

  config = lib.mkIf cfg.enable {
    home-manager = dotnix-utils.hm.hmModule ./impl.nix;
  };
}
