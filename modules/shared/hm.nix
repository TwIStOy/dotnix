{
  config,
  lib,
  dotnix-constants,
  ...
}: let
  cfg = config.dotnix.hm;

  inherit (lib) types;
in {
  options.dotnix.hm = {
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
        dotnix-constants.user.name
        "home"
        "packages"
      ]
      cfg.packages;
  };
}
