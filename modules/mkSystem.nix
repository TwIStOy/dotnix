{
  self,
  inputs,
  nix-darwin,
  nixpkgs,
  home-manager,
  agenix,
  dotnix-constants,
  dotnix-constants-work,
  dotnix-utils,
  dotnix-utils-work,
  vscode-server,
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
    vscode-server.nixosModules.default
    nixosModule
  ];
  platformModules = system:
    [sharedModule]
    ++ (
      if (hasSuffix "darwin" system)
      then darwinModules
      else nixosModules
    );
in {
  mkSystem = {system}: let
    pkgs-unstable = import inputs.nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
      overlays = [
        inputs.neovim-nightly-overlay.overlays.default
      ];
    };
  in
    {
      modules,
      home-modules,
    }: let
      isDarwin = hasSuffix "darwin" system;
      mkSystemImpl =
        if isDarwin
        then nix-darwin.lib.darwinSystem
        else nixpkgs.lib.nixosSystem;
      platModules = platformModules system;
      # inject the specialArgs into all modules and home-manager modules
      specialArgs = {
        inherit dotnix-constants dotnix-utils;
        # unstable channel
        inherit pkgs-unstable;
        # my nur channel
        inherit (inputs) nur-hawtian secrets-hawtian;
        # self!
        inherit self;
        # inject `inputs`
        inherit inputs;
        # inject darwin check
        inherit isDarwin;
      };
    in
      mkSystemImpl {
        inherit system specialArgs;

        modules =
          platModules
          ++ modules
          ++ [
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;

                extraSpecialArgs = specialArgs;
                users."${dotnix-constants.user.name}" = {
                  imports =
                    [
                      ./home
                    ]
                    ++ home-modules;
                };
              };
            }
          ];
      };

  mkWorkSystem = {system}: let
    pkgs-unstable = import inputs.nixpkgs-unstable {
      inherit system;
      config.allowUnfree = true;
      overlays = [
        inputs.neovim-nightly-overlay.overlays.default
      ];
    };
  in
    {
      modules,
      home-modules,
    }: let
      isDarwin = hasSuffix "darwin" system;
      mkSystemImpl =
        if isDarwin
        then nix-darwin.lib.darwinSystem
        else nixpkgs.lib.nixosSystem;
      platModules = platformModules system;
      # inject the specialArgs into all modules and home-manager modules
      specialArgs = {
        dotnix-constants = dotnix-constants-work;
        dotnix-utils = dotnix-utils-work;
        # unstable channel
        inherit pkgs-unstable;
        # my nur channel
        inherit (inputs) nur-hawtian secrets-hawtian;
        # self!
        inherit self;
        # inject `inputs`
        inherit inputs;
        # inject darwin check
        inherit isDarwin;
      };
    in
      mkSystemImpl {
        inherit system specialArgs;

        modules =
          platModules
          ++ modules
          ++ [
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;

                extraSpecialArgs = specialArgs;
                users."${dotnix-constants-work.user.name}" = {
                  imports =
                    [
                      ./home
                    ]
                    ++ home-modules;
                };
              };
            }
          ];
      };
}
