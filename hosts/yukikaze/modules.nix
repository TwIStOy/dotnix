{neon-utils, ...}: let
  inherit (neon-utils) enabled;
in {
  neon.development = {
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
}
