{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.dotnix.services.fava;
in {
  options.dotnix.services.fava = {
    enable = lib.mkEnableOption "Enable module dotnix.services.fava";

    port = lib.mkOption {
      type = lib.types.int;
      default = 5000;
      description = "Port to run fava on";
    };

    home = lib.mkOption {
      type = lib.types.path;
      default = "/var/lib/fava";
      example = "/var/lib/fava";
      description = "Path to the fava data directory";
    };

    mainFile = lib.mkOption {
      type = lib.types.str;
      example = "main.bean";
      description = "Path to the main beancount file";
    };

    accountBookRepo = lib.mkOption {
      type = lib.types.str;
      example = "git@github.com:TwIStOy-contrib/account-book.git";
      description = "URL to the account book repository";
    };
  };

  config = lib.mkIf cfg.enable {
    users.users.fava = {
      isSystemUser = true;
      inherit (cfg) home;
      createHome = true;
      group = "fava";
    };
    users.groups.fava = {};

    systemd.services.fava = {
      description = "Fava beancount web interface";
      wantedBy = ["multi-user.target"];
      wants = [
        "account-book-updater.service"
      ];
      script = ''
        cd ${cfg.home}
        ${pkgs.fava}/bin/fava --host=0.0.0.0 --port=${toString cfg.port} ${cfg.mainFile}
      '';
      serviceConfig = {
        User = "fava";
        Group = "fava";
      };
    };

    systemd.services.account-book-updater = let
      commitFavaUpdateScript = pkgs.writeShellScriptBin "commitFavaUpdateScript" ''
        if ! [[ $(${pkgs.git} status) =~ "working tree clean" ]]; then
          ${pkgs.git}/bin/git add .
          ${pkgs.git}/bin/git commit -m "auto commit"
          ${pkgs.git}/bin/git pull --rebase
          ${pkgs.git}/bin/git push
        fi
      '';
    in {
      description = "Update the account book";
      wantedBy = ["multi-user.target"];
      environment = {
        GIT_SSH_COMMAND = "${pkgs.openssh}/bin/ssh -i /run/agenix/bot-ssh-private-key -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no";
      };
      path = with pkgs; [
        git
        openssh
      ];
      script = ''
        set -e
        cd ${cfg.home}
        if [ ! -d "${cfg.home}/main.bean" ]; then
          echo $GIT_SSH_COMMAND
          git init
          git remote rm origin || true
          git remote add origin ${cfg.accountBookRepo}
          git fetch
          git checkout -t origin/master
        fi
        ${pkgs.watchexec}/bin/watchexec -r -e bean,beancount -w ${cfg.home} ${commitFavaUpdateScript}
      '';
      serviceConfig = {
        User = "fava";
        Group = "fava";
      };
    };
  };
}
