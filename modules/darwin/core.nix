{
  pkgs,
  dotnix-constants,
  ...
}: let
  inherit (dotnix-constants) user;
in {
  services.nix-daemon.enable = true;
  nix = {
    package = pkgs.nix;

    settings.auto-optimise-store = false;
    gc.automatic = false;
  };

  nixpkgs.config.allowUnfree = true;

  users.users."${user.name}" = {
    home = "/Users/${user.name}";
  };
}
