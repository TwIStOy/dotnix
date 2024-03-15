{dotnix-utils, ...}: let
  inherit (dotnix-utils) enabled;
in {
  dotnix.darwin-shared-suit = enabled;

  dotnix.desktop.neovide.extraSettings.font.size = 22;
}
