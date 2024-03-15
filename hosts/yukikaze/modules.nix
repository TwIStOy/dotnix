{
  pkgs,
  dotnix-utils,
  ...
}: let
  inherit (dotnix-utils) enabled enableModules;
in {
  dotnix = {
    development = {
      build-tools = {
        enable = true;
        unstable = [
          "cmake"
        ];
      };
      languages = {
        all = enabled;
      };
    };

    suits = enableModules [
      "desktop"
      "devops"
      "development"
    ];
  };
}
