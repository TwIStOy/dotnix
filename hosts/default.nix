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
in {
  darwinConfigurations = {
    yamato = mkIntelDarwinSystem (import ./yamato);
    yukikaze = mkArmDarwinSystem (import ./yukikaze);
  };
}
