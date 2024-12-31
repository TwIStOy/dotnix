{
  modules = [
    ./iso-configuration.nix
    ./modules.nix
    # ./disko.nix
    ({
      inputs,
      config,
      ...
    }: {
      imports = [
        inputs.nixos-generators.nixosModules.all-formats
      ];
      nixpkgs.hostPlatform = "x86_64-linux";
    })
  ];
  home-modules = [];
}
