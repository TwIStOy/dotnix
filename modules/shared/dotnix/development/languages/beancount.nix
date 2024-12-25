{
  config,
  pkgs,
  lib,
  dotnix-constants,
  ...
}
: let
  cfg = config.dotnix.development.languages.beancount;
  inherit (dotnix-constants) user;
  homeDir = config.users.users."${user.name}".home;
in {
  options.dotnix.development.languages.beancount = {
    enable = lib.mkEnableOption "Enable beancount";

    favaService = {
      enable = lib.mkEnableOption "Enable fava service";

      port = lib.mkOption {
        type = lib.types.int;
        default = 5000;
        description = "Port to run fava on";
      };

      mainFile = lib.mkOption {
        type = lib.types.path;
        default = "${homeDir}/account-book/main.bean";
        description = "Path to the main beancount file";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    dotnix.hm.packages = with pkgs; [
      beancount
      fava
    ];

    systemd = lib.mkIf cfg.favaService.enable {
      services.fava = {
        description = "Fava beancount web interface";
        wantedBy = ["multi-user.target"];
        script = ''
          ${pkgs.fava}/bin/fava --host=0.0.0.0 --port=${toString cfg.favaService.port} ${cfg.favaService.mainFile}
        '';
      };
    };
  };
}
