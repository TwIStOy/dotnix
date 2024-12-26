{isDarwin, ...}: {
  imports =
    [
      ./github-runner.nix
      ./tailscale.nix
    ]
    ++ (
      if (!isDarwin)
      then [
        ./fava.nix
      ]
      else []
    );
}
