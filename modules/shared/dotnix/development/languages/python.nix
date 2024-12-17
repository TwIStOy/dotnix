{
  config,
  pkgs,
  lib,
  dotnix-utils,
  ...
}: let
  cfg = config.dotnix.development.languages.python;
in {
  options.dotnix.development.languages.python = {
    enable = lib.mkEnableOption "Enable dev lang python";
  };

  config = lib.mkIf cfg.enable {
    dotnix.hm.packages = with pkgs; [
      pyright # python language server

      (python3.withPackages (ps:
        with ps; [
          ruff-lsp
          black # python formatter

          jupyter
          ipython
          pandas
          requests
          pyquery
          pyyaml

          setuptools
          qrcode
          lxml
          psutil
          pip
        ]))
    ];
    home-manager =
      dotnix-utils.hm.hmConfig {
      };
  };
}
