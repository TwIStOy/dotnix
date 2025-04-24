{
  config,
  pkgs-unstable,
  lib,
  ...
}
: let
  cfg = config.dotnix.development.languages.beancount;
in {
  options.dotnix.development.languages.beancount = {
    enable = lib.mkEnableOption "Enable beancount";
  };

  config = lib.mkIf cfg.enable {
    dotnix.hm.packages = with pkgs-unstable; [
      beancount
      fava
    ];
  };
}
