{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  # dotnix-utils,
  # inputs,
  ...
}: let
  cfg = config.dotnix.suits.desktop;
  # inherit (dotnix-utils) enableModules;
  # neovim-nightly = inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
in {
  options.dotnix.suits.desktop = {
    enable = lib.mkEnableOption "Enable desktop suit";
  };

  config = lib.mkIf cfg.enable {
    dotnix.desktop = {
      kitty = {
        enable = true;
      };

      neovide = {
        enable = true;
        package =
          if pkgs.stdenv.isDarwin
          then "homebrew"
          else "unstable";
        skipPackage = true;
        createRemoteHostWrappers = [
          "poi.remote"
          "poi.local"
          "dev.work.local"
          "dev.work.local.simple"
          "dev.work.remote"
        ];
        settings =
          {
            maximized = false;
            srgb = true;
            idle = true;
            neovim-bin = pkgs-unstable.neovim;
          }
          // (lib.optionalAttrs pkgs.stdenv.isDarwin {
            frame = "transparent";
          });
        extraSettings = {
          font = {
            normal = {family = "Maple Mono NF CN";};
            # bold = "MonaspiceKr Nerd Font Mono";
            # bold_italic = "MonaspiceKr Nerd Font Mono";
            features."Maple Mono NF CN" = [
              "+ss01"
              "+ss02"
            ];
            features."MonoLisa Nerd Font" = [
              "+ss11"
              "+zero"
              "-calt"
              "+ss10"
              "+ss02"
              "+ss17"
              "+ss13"
              "+ss04"
            ];
          };
          vsync = true;
        };
      };
    };
  };
}
