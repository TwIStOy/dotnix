{inputs, ...}: {
  nixpkgs.overlays = [
    inputs.neovim-nightly-overlay.overlays.default
    inputs.fenix.overlays.default
  ];
}
