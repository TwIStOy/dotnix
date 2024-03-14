{inputs, ...}: {
  nixpkgs.overlays = [
    inputs.neovim-nightly-overlay.overlay
    inputs.fenix.overlays.default
  ];
}
