{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.dotnix.services.github-runner;
in {
  options.dotnix.services.github-runner = {
    enable = lib.mkEnableOption "Enable module dotnix.services.github-runner";
  };

  config = lib.mkIf cfg.enable {
    services.github-runners = {
      runner1 = {
        enable = true;
        name = "linux-poi";
        tokenFile = "/run/agenix/github-runners-poi-aaku";
        url = "https://github.com/aaku-works";
        extraPackages = with pkgs; [
          docker
        ];
      };
    };
  };
}
