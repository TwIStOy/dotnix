{
  modules = [
    ./frp.nix
    ./hardware-configuration.nix
    ./modules.nix
    ./system.nix
    ./virtualisation
  ];
  home-modules = [
    ./home.nix
  ];
}
