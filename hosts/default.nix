{
  mkSystem,
  nixpkgs,
  flake-utils,
  deploy-rs,
  vars,
  ...
}: let
  makeSystemDrv = {
    name,
    system,
    path,
    env ? "default",
  }: let
    systemDrv = mkSystem {
      inherit system env;
    } (import "${path}");
    constants = vars.varFor env;

    pkgs = import nixpkgs {inherit system;};
    deployPkgs = import nixpkgs {
      inherit system;
      overlays = [
        deploy-rs.overlay
        (self: super: {
          deploy-rs = {
            inherit (pkgs) deploy-rs;
            inherit (super.deploy-rs) lib;
          };
        })
      ];
    };
    inherit (nixpkgs.lib.strings) hasSuffix;
    isDarwin = hasSuffix "darwin" system;
    activateFn =
      if isDarwin
      then deployPkgs.deploy-rs.lib.activate.darwin
      else deployPkgs.deploy-rs.lib.activate.nixos;
  in
    {
      deploy.nodes."${name}" = {
        hostname = name;
        profiles.system = {
          sshUser = constants.user.user.name;
          activationTimeout = 6000;
          path = activateFn systemDrv;
        };
      };
    }
    // (
      if isDarwin
      then {
        darwinConfigurations = {
          "${name}" = systemDrv;
        };
      }
      else {
        nixosConfigurations = {
          "${name}" = systemDrv;
        };
      }
    );

  mkSimpleSystem = system: name
  :
    makeSystemDrv {
      inherit name system;
      path = ./${name};
    };
  mkIntelDarwinSystem = mkSimpleSystem flake-utils.lib.system.x86_64-darwin;
  mkArmDarwinSystem = mkSimpleSystem flake-utils.lib.system.aarch64-darwin;
  mkX64LinuxSystem = mkSimpleSystem flake-utils.lib.system.x86_64-linux;

  yamato = mkIntelDarwinSystem "yamato";
  yukikaze = mkArmDarwinSystem "yukikaze";
  nagato = makeSystemDrv {
    name = "nagato";
    system = flake-utils.lib.system.aarch64-darwin;
    path = ./nagato;
    env = "tesla";
  };
  poi = mkX64LinuxSystem "poi";
  taihou = mkX64LinuxSystem "taihou";
  # mutsu = makeSystemDrv {
  #   name = "mutsu";
  #   system = flake-utils.lib.system.x86_64-linux;
  #   path = ./mutsu;
  #   env = "tesla";
  # };

  # checks2 = builtins.mapAttrs (system: deployLib: deployLib.deployChecks self.deploy) inputs.deploy-rs.lib;

  recursiveMergeAttrs = attrs: builtins.foldl' (acc: ext: nixpkgs.lib.attrsets.recursiveUpdate acc ext) {} attrs;
in
  recursiveMergeAttrs [
    yamato
    yukikaze
    nagato
    poi
    taihou
    # mutsu
  ]
