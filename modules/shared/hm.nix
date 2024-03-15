{
  config,
  lib,
  neon-constants,
  ...
}: let
  cfg = config.neon.hm;

  inherit (lib) types;
in {
  options.neon.hm = {
    enable = lib.mkEnableOption "Enable home-manager integration";

    packages = lib.mkOption {
      type = types.listOf types.package;
      default = [];
      description = "The set of packages to appear in the user environment.";
    };
  };

  config = lib.mkIf cfg.enable {
    home-manager =
      lib.attrsets.setAttrByPath [
        "users"
        neon-constants.user.name
        "home"
        "packages"
      ]
      cfg.packages;
  };
}
