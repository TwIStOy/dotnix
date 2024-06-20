{inputs, ...}: {
  nixpkgs.overlays = [
    inputs.fenix.overlays.default
  ];
}
