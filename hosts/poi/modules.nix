{pkgs, ...}: {
  dotnix = {
    nixos-shared-suit = {
      enable = true;
    };
    desktop.neovide.extraSettings.font.size = 22;
    apps.ollama = {
      enable = false;
    };
    services.tailscale = {
      enable = true;
      extraUpFlags = [
        "--advertise-tags=tag:homeserver"
        "--ssh"
      ];
    };
  };

  services.github-runners = {
    append = {
      enable = true;
      name = "poi";
      tokenFile = "/run/agenix/github-actions-runner-token";
      url = "https://github.com/TwIStOy-contrib";
      extraLabels = [
        "nixos"
      ];
      replace = true;
      extraPackages = with pkgs; [
        docker
      ];
    };
  };
}
