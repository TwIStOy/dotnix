{
  pkgs,
  pkgs-unstable,
  ...
}: {
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
    general-private-contrib = {
      enable = true;
      name = "poi-private-contrib";
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
    account-book = {
      enable = true;
      name = "poi-account-book";
      tokenFile = "/run/agenix/github-actions-runner-token";
      url = "https://github.com/TwIStOy-contrib";
      extraLabels = [
        "nixos"
        "beancount"
      ];
      runnerGroup = "beancount";
      replace = true;
      extraPackages = with pkgs-unstable; [
        beancount
      ];
    };
  };
}
