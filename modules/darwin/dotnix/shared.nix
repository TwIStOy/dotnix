{
  config,
  lib,
  dotnix-constants,
  dotnix-utils,
  ...
}: let
  inherit (dotnix-constants) user;
  cfg = config.dotnix.darwin-shared;
in {
  options.dotnix.darwin-shared = {
    enable = lib.mkEnableOption "Enable module dotnix.darwin-shared";
  };

  config = lib.mkIf cfg.enable {
    home-manager = dotnix-utils.hm.hmConfig {
      home.homeDirectory = lib.mkForce "/User/${user.name}";
    };
  };
}
