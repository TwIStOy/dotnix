{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.neon.development.languages.dart;
in {
  options.neon.development.languages.dart = {
    enable = lib.mkEnableOption "Enable Dart";
  };

  config = lib.mkIf cfg.enable {
    neon.hm.packages =
      if pkgs.stdenv.isDarwin
      then
        with pkgs; [
          dart
          cocoapods
        ]
      else
        with pkgs; [
          flutter
        ];

    homebrew = {
      taps = [
        "leoafarias/fvm"
      ];
      brews = [
        "fvm"
      ];
    };
  };
}
