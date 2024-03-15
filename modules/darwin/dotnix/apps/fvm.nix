{
  config,
  lib,
  ...
}: let
  cfg = config.dotnix.development.languages.dart;
in {
  config = lib.mkIf cfg.enable {
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
