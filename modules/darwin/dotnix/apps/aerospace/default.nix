{
  config,
  lib,
  dotnix-utils,
  dotnix-constants,
  ...
}: let
  cfg = config.dotnix.apps.aerospace;
  inherit (dotnix-constants) user;
  homeDir = config.users.users."${user.name}".home;
in {
  options.dotnix.apps.aerospace = {
    enable = lib.mkEnableOption "Enable module dotnix.apps.aerospace";
  };

  config = lib.mkIf cfg.enable {
    homebrew = {
      casks = ["nikitabobko/tap/aerospace"];
    };

    home-manager = dotnix-utils.hm.hmConfig {
      home = {
        file = {
          "${homeDir}/.aerospace.toml" = {
            text = builtins.readFile ./aerospace.toml;
            force = true;
          };
        };
      };
    };
  };
}
