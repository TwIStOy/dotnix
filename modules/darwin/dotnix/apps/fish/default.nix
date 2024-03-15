{
  config,
  lib,
  dotnix-utils,
  ...
}: let
  cfg = config.dotnix.apps.fish;
in {
  config = lib.mkIf cfg.enable {
    home-manager = dotnix-utils.hm.hmModule ./home.nix;
  };
}
