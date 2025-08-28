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
      xdg.configFile."aerospace/display-info.sh" = {
        text = builtins.readFile ./display-info.sh;
        force = true;
        executable = true;
      };

      xdg.configFile."aerospace/moving-floating.sh" = {
        text = builtins.readFile ./moving-floating.sh;
        force = true;
        executable = true;
      };

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
