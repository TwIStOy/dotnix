{
  config,
  lib,
  dotnix-utils,
  ...
}: let
  cfg = config.dotnix.apps.neovim;
in {
  options.dotnix.apps.neovim = {
    enable = lib.mkEnableOption "Enable module dotnix.apps.neovim";
  };

  config = lib.mkIf cfg.enable {
    home-manager = dotnix-utils.hm.hmModule ./home.nix;
  };
}
