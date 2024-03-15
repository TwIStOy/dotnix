{
  inputs,
  dotnix-constants,
}: let
  moduleArgs =
    {
      inherit dotnix-constants;
    }
    // inputs;
in {
  path = import ./path.nix moduleArgs;

  hm = import ./hm.nix {inherit inputs dotnix-constants;};

  # shortcuts
  enabled = {
    enable = true;
  };
}
