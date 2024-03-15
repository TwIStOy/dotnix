{dotnix-constants, ...}: let
  inherit (dotnix-constants) user;
in {
  users.mutableUsers = false;

  users.users."${user.name}" = {
    home = "/home/${user.name}";
    description = "${user.fullName}";
    isNormalUser = true;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
  };

  security.sudo.wheelNeedsPassword = false;
}
