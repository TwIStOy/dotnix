{
  mkSystem,
  flake-utils,
  ...
}: let
  mkIntelDarwinSystem = mkSystem {
    system = flake-utils.lib.system.x86_64-darwin;
  };
  mkArmDarwinSystem = mkSystem {
    system = flake-utils.lib.system.aarch64-darwin;
  };
  mkIntelLinuxSystem = mkSystem {
    system = flake-utils.lib.system.x86_64-linux;
  };
in {
  darwinConfigurations = {
    yamato = mkIntelDarwinSystem (import ./yamato);
    yukikaze = mkArmDarwinSystem (import ./yukikaze);
  };
  nixosConfigurations = {
    poi = mkIntelLinuxSystem (import ./poi);
  };
}
