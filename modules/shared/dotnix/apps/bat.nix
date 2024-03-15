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
        };
        themes = {
          catppuccin-mocha = {
            src = builtins.fetchurl {
              url = "https://raw.githubusercontent.com/catppuccin/bat/main/Catppuccin-mocha.tmTheme";
              sha256 = "sha256:1z434yxjq95bbfs9lrhcy2y234k34hhj5frwmgmni6j8cqj0vi58";
            };
          };
        };
      };
    };
  };
}
