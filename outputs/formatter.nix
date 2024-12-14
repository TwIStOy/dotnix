{
  flake-utils,
  nixpkgs-unstable,
  ...
}:
flake-utils.lib.eachDefaultSystem (system: {
  formatter = nixpkgs-unstable.legacyPackages.${system}.alejandra;
})
