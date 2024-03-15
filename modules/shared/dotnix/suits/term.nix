{
  config,
  lib,
  dotnix-utils,
  ...
}: let
  inherit (dotnix-utils) enabled enableModules;
  cfg = config.dotnix.suits.term;
in {
  options.dotnix.suits.term = {
    enable = lib.mkEnableOption "Enable module dotnix.suits.term";
  };

  config = lib.mkIf cfg.enable {
    dotnix = {
      apps = enableModules [
        "eza"
        "fish"
        "neovim"
        "rime_ls"
        "starship"
        "tealdeer"
        "tmux"
        "yazi"
        "zoxide"
      ];
    };

    home-manager =
      dotnix-utils.hm.hmConfig {
      };
  };
}
