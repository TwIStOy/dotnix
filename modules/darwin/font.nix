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
    version = "v7.0-beta33";
    url = "https://github.com/subframe7536/maple-font/releases/download/$VERSION/MapleMono-NF-CN.zip";
    sha256 = "0n5wyy8183961dnh9abvmq1ac1q2jf8s2skmxwrb3g2m852pdwa4";
    followRedirects = false;
  };
in {
  fonts.packages =
    [
      monolisa
      akzidenz-grotesk
      maple-font
      lxgw-wenkai
      readex-pro

      pkgs-unstable.monaspace
    ]
    ++ (with pkgs-unstable.nerd-fonts; [
      symbols-only
      fira-code
      jetbrains-mono
      iosevka
      monaspace
    ]);
}
