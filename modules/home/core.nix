{dotnix-constants, ...}: {
  home = {
    username = dotnix-constants.user.name;
    stateVersion = "23.11";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
