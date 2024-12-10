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
  mkX64LinuxSystem = mkSystem {
    system = flake-utils.lib.system.x86_64-linux;
  };
in {
  darwinConfigurations = {
    yamato = mkIntelDarwinSystem (import ./yamato);
    yukikaze = mkArmDarwinSystem (import ./yukikaze);
    nagato = mkSystem {
      system = flake-utils.lib.system.aarch64-darwin;
      env = "tesla";
    } (import ./nagato);
  };
  nixosConfigurations = {
    poi = mkX64LinuxSystem (import ./poi);
    taihou = mkX64LinuxSystem (import ./taihou);
    mutsu = mkSystem {
      system = flake-utils.lib.system.x86_64-linux;
      env = "tesla";
    } (import ./mutsu);
  };
}
