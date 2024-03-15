{
  inputs,
  neon-constants,
}: let
  moduleArgs =
    {
      inherit neon-constants;
    }
    // inputs;
in {
  path = import ./path.nix moduleArgs;

  attrs = import ./attrs.nix {inherit inputs neon-constants;};

  # shortcuts
  enabled = {
    enable = true;
  };
}
