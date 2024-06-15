{
  pkgs,
  pkgs-unstable,
  secrets-hawtian,
  lib,
  ...
}: let
  monolisa = pkgs.stdenv.mkDerivation {
    pname = "monolisa";
    version = "2.015";
    src = "${secrets-hawtian}/fonts/";

    installPhase = ''
      runHook preInstall

      install -Dm644 *.ttf -t $out/share/fonts/truetype

      runHook postInstall
    '';

    meta = {
      description = "Monolisa font";
      platforms = lib.platforms.all;
    };
  };

  maple-font = pkgs.stdenv.mkDerivation rec {
    pname = "maple-font";
    version = "v7.0-beta21";
    src = builtins.fetchurl {
      url = "https://github.com/subframe7536/maple-font/releases/download/${version}/MapleMono-NF-CN.zip";
      sha256 = "07ywfldi23h3yx1di2dzlbxwh3vvycny2bslxwq96gan82cqd0qn";
    };
    nativeBuildInputs = with pkgs; [unzip];
    sourceRoot = ".";

    dontPatch = true;
    dontConfigure = true;
    dontBuild = true;
    doCheck = false;
    dontFixup = true;

    installPhase = ''
      runHook preInstall

      install -Dm64 *.ttf -t $out/share/fonts/truetype

      runHook postInstall
    '';
  };
in {
  fonts.packages = [
    monolisa
    maple-font

    pkgs.monaspace
    # nerdfonts
    # https://github.com/NixOS/nixpkgs/blob/nixos-24.05/pkgs/data/fonts/nerdfonts/shas.nix
    (pkgs-unstable.nerdfonts.override {
      fonts = [
        # symbols icon only
        "NerdFontsSymbolsOnly"
        # Characters
        "FiraCode"
        "JetBrainsMono"
        "Iosevka"
        "Monaspace"
      ];
    })
  ];
}
