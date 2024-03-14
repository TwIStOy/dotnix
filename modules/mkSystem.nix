{
  inputs,
  nix-darwin,
  nixpkgs,
  home-manager,
  agenix,
  neon-constants,
  neon-utils,
  ...
}: let
  inherit (nixpkgs.lib.strings) hasSuffix;
  sharedModule = import ./shared;
  nixosModule = import ./nixos;
  darwinModule = import ./darwin;

  darwinModules = [
    home-manager.darwinModules.home-manager
    agenix.darwinModules.default
    darwinModule
  ];
  nixosModules = [
    home-manager.nixosModules.home-manager
    agenix.nixosModules.default
    nixosModule
  ];
  platformModules = system:
    [sharedModule]
    ++ (
      if (hasSuffix "darwin" system)
      then darwinModules
      else nixosModules
    );
in
  {
    system,
    modules,
    home-modules,
  }: let
    mkSystemImpl =
      if (hasSuffix "darwin" system)
      then nix-darwin.lib.darwinSystem
      else nixpkgs.lib.nixosSystem;
    platModules = platformModules system;
    specialArgs = {
      inherit neon-constants neon-utils;
    };
  in {
    flake-outputs = mkSystemImpl {
      inherit inputs system specialArgs;

      modules =
        platModules
        ++ modules
        ++ [
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;

              extraSpecialArgs = specialArgs;
              users."${neon-constants.user.name}" = {
                imports = [./home] ++ home-modules;
              };
            };
          }
        ];
    };
  }
