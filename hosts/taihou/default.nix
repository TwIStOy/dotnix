{
  modules = [
    ./hardware-configuration.nix
    ./modules.nix
    ./system.nix
  ];
  home-modules = [
    ./home.nix
  ];
}
