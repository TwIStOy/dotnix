{
  config,
  neon-utils,
  lib,
  ...
}: let
  cfg = config.neon.development.languages.all;
  inherit (neon-utils) enabled;
in {
  options.neon.development.languages.all = {
    enable = lib.mkEnableOption "Enable all languages";
  };

  config = lib.mkIf cfg.enable {
    neon.development.languages = {
      cpp = enabled;
      golang = enabled;
      dart = enabled;
    };
  };
}
