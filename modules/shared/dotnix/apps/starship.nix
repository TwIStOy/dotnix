{
  config,
  pkgs,
  lib,
  dotnix-utils,
  ...
}: let
  cfg = config.dotnix.apps.starship;

  theme-catppuccin = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "starship";
    rev = "e99ba6b210c0739af2a18094024ca0bdf4bb3225";
    sha256 = "sha256-1w0TJdQP5lb9jCrCmhPlSexf0PkAlcz8GBDEsRjPRns=";
  };
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

        settings =
          {
            palette = "catppuccin_mocha";
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
          }
          // lib.importTOML "${theme-catppuccin}/themes/frappe.toml"
          // lib.importTOML "${theme-catppuccin}/themes/latte.toml"
          // lib.importTOML "${theme-catppuccin}/themes/macchiato.toml"
          // lib.importTOML "${theme-catppuccin}/themes/mocha.toml";
      };
    };
  };
}
