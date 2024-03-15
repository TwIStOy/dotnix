{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}: let
  cfg = config.dotnix.development.build-tools;
in {
  options.dotnix.development.build-tools = {
    enable = lib.mkEnableOption "Enable development build tools";

    unstable = lib.mkOption {
      type = lib.types.listOf lib.types.str;
      default = [];
      description = "List of packages use unstable version";
    };
  };

  config = lib.mkIf cfg.enable {
    dotnix.hm.packages = let
      inherit (cfg) unstable;
      resolvePkg = pkg:
        if (builtins.elem pkg unstable)
        then pkgs-unstable.${pkg}
        else pkgs.${pkg};
      ret = [
        # for makefile
        "gnumake"
        # for ninja file
        "ninja"
        # find library
        "pkg-config"
        # generate makefile/ninja file
        "cmake"
        # for justfile
        "just"
      ];
      retPkg = builtins.map resolvePkg ret;
    in
      retPkg;
  };
}
