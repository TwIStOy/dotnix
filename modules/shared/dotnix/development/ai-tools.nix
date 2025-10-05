{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}: let
  cfg = config.dotnix.development.ai-tools;
in {
  options.dotnix.development.ai-tools = {
    enable = lib.mkEnableOption "Enable development ai tools";

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
        # GitHub Copilot CLI
        "github-copilot-cli"
      ];
      retPkg = builtins.map resolvePkg ret;
    in
      retPkg;
  };
}
