{
  config,
  pkgs,
  lib,
  dotnix-utils,
  ...
}: let
  cfg = config.dotnix.utils.rime-scheme;

  rime-shuangpin-fuzhuma = pkgs.fetchFromGitHub {
    owner = "gaboolic";
    repo = "rime-shuangpin-fuzhuma";
    rev = "1.0.0";
    sha256 = "sha256-ArETWI/pZvzuOakFXSPLNkQ831WXz5y0JtcsXR0hwX8=";
  };
in {
  options.dotnix.utils.rime-scheme = {
    enable = lib.mkEnableOption "Rime Scheme";
  };

  config = lib.mkIf cfg.enable {
    home-manager = dotnix-utils.hm.hmConfig {
      xdg.dataFile.shared-rime-scheme = {
        source = rime-shuangpin-fuzhuma;
        recursive = true;
      };
    };
  };
}
