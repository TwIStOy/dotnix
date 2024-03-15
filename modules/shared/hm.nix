{
  config,
  lib,
  neon-constants,
  ...
}: let
  cfg = config.neon.hm;
in {
  options.neon.hm = {
    enable = lib.mkEnableOption "Enable home-manager integration";
    config = lib.mkOption {
      type = lib.types.attrsOf lib.types.attrs;
      default = {};
      description = "The home-manager configuration to use for the user";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager =
      lib.attrsets.setAttrByPath [
        "users"
        neon-constants.user.name
      ]
      cfg.config;
  };
}
