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

  # shortcuts
  enabled = {
    enable = true;
  };
}
