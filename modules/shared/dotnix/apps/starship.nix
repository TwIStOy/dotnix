{
  config,
  lib,
  dotnix-utils,
  ...
}: let
  cfg = config.dotnix.apps.starship;
in {
  options.dotnix.apps.starship = {
    enable = lib.mkEnableOption "Enable module dotnix.apps.starship";
  };

  config = lib.mkIf cfg.enable {
    home-manager = dotnix-utils.hm.hmConfig {
      programs.starship = {
        enable = true;

        enableBashIntegration = true;
        enableZshIntegration = true;
        enableFishIntegration = true;

        settings = {
          character = {
            success_symbol = "[](bold green)";
            error_symbol = "[](bold red)";
          };
          cmd_duration = {
            disabled = true;
          };
          git_branch = {
            symbol = " ";
            ignore_branches = ["master" "main"];
          };
          git_metrics = {
            disabled = false;
            ignore_submodules = true;
          };
          lua = {
            version_format = "v\${major}.\${minor}";
          };
          nix_shell = {
            heuristic = true;
          };
        };
      };
    };
  };
}
