{
  pkgs,
  dotnix-constants,
  ...
}: let
  inherit (dotnix-constants) user;
in {
  nix = {
    enable = false;

    package = pkgs.nix;

    # Disable auto-optimise-store because of this issue:
    #   https://github.com/NixOS/nix/issues/7273
    # "error: cannot link '/nix/store/.tmp-link-xxxxx-xxxxx' to '/nix/store/.links/xxxx': File exists"
    settings.auto-optimise-store = false;

    gc.automatic = false;
  };

  nixpkgs.config.allowUnfree = true;

  # Required for options that previously applied to invoking user (system.defaults.* etc.)
  system.primaryUser = user.name;

  users.users."${user.name}" = {
    home = "/Users/${user.name}";
  };
}
