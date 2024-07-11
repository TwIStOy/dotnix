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
    src = "${secrets-hawtian}/fonts/MonoLisa";

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

  akzidenz-grotesk = pkgs.stdenv.mkDerivation {
    pname = "akzidenz-grotesk";
    version = "1.0";
    src = "${secrets-hawtian}/fonts/Akzidenz-Grotesk";

    installPhase = ''
      runHook preInstall
      install -Dm644 *.otf -t $out/share/fonts/truetype
      runHook postInstall
    '';

    meta = {
      description = "Akzidenz Grotesk font";
      platforms = lib.platforms.all;
    };
  };

  readex-pro = pkgs.stdenv.mkDerivation {
    pname = "readex-pro";
    version = "1.0";
    src = "${secrets-hawtian}/fonts/ReadexPro";

    installPhase = ''
      runHook preInstall
      install -Dm644 *.ttf -t $out/share/fonts/truetype
      runHook postInstall
    '';

    meta = {
      description = "Readex font";
      platforms = lib.platforms.all;
    };
  };

  fontFromGithub = {
    name,
    url,
    sha256,
    version,
    followRedirects ? true,
  }:
    pkgs.stdenv.mkDerivation ({
        pname = name;
        inherit version;
        src = builtins.fetchurl {
          url = builtins.replaceStrings ["$VERSION"] [version] url;
          inherit sha256;
        };
        nativeBuildInputs = with pkgs; [unzip];

        dontPatch = true;
        dontConfigure = true;
        dontBuild = true;
        doCheck = false;
        dontFixup = true;

        installPhase = ''
          runHook preInstall
          install -Dm644 *.ttf -t $out/share/fonts/truetype
          runHook postInstall
        '';
      }
      // lib.optionalAttrs (!followRedirects) {
        sourceRoot = ".";
      });

  lxgw-wenkai = fontFromGithub {
    name = "lxgw-wenkai";
    version = "v1.330";
    url = "https://github.com/lxgw/LxgwWenKai/releases/download/$VERSION/lxgw-wenkai-$VERSION.zip";
    sha256 = "033qc5xyxdf777sa6xxipg86ch2jbyybvfhw8yzwl20690apwc9g";
  };

  maple-font = fontFromGithub {
    name = "maple-font";
    version = "v7.0-beta21";
    url = "https://github.com/subframe7536/maple-font/releases/download/$VERSION/MapleMono-NF-CN.zip";
    sha256 = "07ywfldi23h3yx1di2dzlbxwh3vvycny2bslxwq96gan82cqd0qn";
    followRedirects = false;
  };
in {
  fonts.packages = [
    monolisa
    akzidenz-grotesk
    maple-font
    lxgw-wenkai
    readex-pro

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
