rec {
  concat-family-variant = {
    family,
    variant,
  }:
    if family == ""
    then variant
    else if variant == ""
    then family
    else family + "-" + variant;

  to-font-config = {
    family,
    variants,
    features,
    extra-config ? "",
  }: let
    full-names = builtins.map (x:
      concat-family-variant {
        inherit family;
        variant = x;
      })
    variants;
    full-names-features = builtins.map (x: x + " " + features) full-names;
    lines = builtins.map (x: "font_features " + x) full-names-features;
  in ''
    ${builtins.foldl' (x: y: x + "\n" + y) "" lines}
    ${extra-config}
  '';

  map-nerd-icon-ranges = {family}: let
    nerd-icon-ranges = [
      # Seti-UI + Custom
      "U+E5FA-U+E6FF"

      # Heavy Angle Brackets
      "U+276C-U+2771"

      # Box Drawing
      "U+2500-U+259F"

      # Devicons
      "U+E700-U+E7C5"

      # Powerline Symbols
      "U+E0A0-U+E0A2,U+E0B0-U+E0B3"
      # Powerline Extra Symbols
      "U+E0A3,U+E0B4-U+E0C8,U+E0CA,U+E0CC-U+E0D4,U+2630"

      # Pomicons
      "U+E000-U+E00A"

      # Font Awesome
      "U+F000-U+F2E0"

      # Font Awesome Extension
      "U+E200-U+E2A9"

      # Material Design Icons
      "U+F0001-U+F1AF0"

      # Power symbols
      "U+23FB-U+23FE,U+2B58"

      # Weather
      "U+E300-U+E3EB"

      # Octicons
      "U+F400-U+F505,U+2665,U+26A1,U+F4A9-U+F532,U+EA60-U+EBEB"

      # Font Logos
      "U+F300-U+F32F"
    ];
    lines = builtins.map (x: "symbol_map " + x + " " + family) nerd-icon-ranges;
  in
    builtins.foldl' (x: y: x + "\n" + y) "" lines;
}
