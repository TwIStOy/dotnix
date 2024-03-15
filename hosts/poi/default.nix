{
  modules = [
    ./frp.nix
    ./hardware-configuration.nix
    ./modules.nix
  ];
  home-modules = [
    ./home.nix
  ];
}
