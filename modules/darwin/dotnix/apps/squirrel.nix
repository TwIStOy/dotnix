{
  config,
  pkgs,
  lib,
  dotnix-utils,
  ...
}: let
  cfg = config.dotnix.apps.squirrel;
  toYAML = pkgs.lib.generators.toYAML {};
in {
  options.dotnix.apps.squirrel = {
    enable = lib.mkEnableOption "Squirrel - Rime for Mac";
  };
  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = pkgs.stdenv.isDarwin;
        message = "Hammerspoon only works on macOS";
      }
    ];

    homebrew = {
      casks = ["squirrel"];
    };

    home-manager = dotnix-utils.hm.hmConfig {
      home.file."Library/Rime" = {
        source = pkgs.fetchFromGitHub {
          owner = "gaboolic";
          repo = "rime-shuangpin-fuzhuma";
          rev = "2f32d39b805dd026704f7a824e2013595a70b7e3";
          sha256 = "sha256-96vcD7f7ldOWLZyQkvFxsID8GQ7xy7rQToWvy877xlE=";
        };
        recursive = true;
      };

      home.file."Library/Rime/squirrel.custom.yaml" = {
        text = toYAML {
          patch = {
            "style/horizontal" = true;
            "style/font_point" = 18;
            "style/font_face" = "Maple Mono NF CN";
          };
          # style/color_scheme: mac_light
          # style/color_scheme_dark: mac_dark
        };
      };
    };
  };
}
