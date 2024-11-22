{
  config,
  lib,
  dotnix-utils,
  ...
}: let
  cfg = config.dotnix.apps.bat;
in {
  options.dotnix.apps.bat = {
    enable = lib.mkEnableOption "Enable module dotnix.apps.bat";
  };

  config = lib.mkIf cfg.enable {
    home-manager = dotnix-utils.hm.hmConfig {
      programs.bat = {
        enable = true;
        config = {
          pager = "less -FR";
          theme = "catppuccin-mocha";
          map-syntax = [
            "**/flake.lock:JSON"
          ];
        };
        themes = {
          catppuccin-mocha = {
            src = builtins.fetchurl {
              name = "bat-theme-catppuccin-mocha";
              url = "https://raw.githubusercontent.com/catppuccin/bat/d2bbee4f7e7d5bac63c054e4d8eca57954b31471/themes/Catppuccin%20Mocha.tmTheme";
              sha256 = "sha256:0jrpfd06hviw82xl74m3favq58a586wa7h1qymakx14l8zla26sh";
            };
          };
        };
      };
    };
  };
}
