{
  modules = [
    ./hardware-configuration.nix
    ./modules.nix
    ./system.nix
    ./frp.nix
  ];
  home-modules = [
    ./home.nix
  ];
}
