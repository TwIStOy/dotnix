{
  pkgs,
  pkgs-unstable,
  config,
  lib,
  isDarwin,
  ...
}: let
  cfg = config.dotnix.services.tailscale;

  authKeyFile = "/run/agenix/tailscale-auth-key";

  paramToString = v:
    if (builtins.isBool v)
    then (lib.boolToString v)
    else (toString v);
  params = lib.pipe cfg.authKeyParameters [
    (lib.filterAttrs (_: v: v != null))
    (lib.mapAttrsToList (k: v: "${k}=${paramToString v}"))
    (builtins.concatStringsSep "&")
    (params:
      if params != ""
      then "?${params}"
      else "")
  ];

  autoConnectScript = let
    statusCommand = "${lib.getExe cfg.package} status --json --peers=false | ${lib.getExe pkgs.jq} -r '.BackendState'";
  in
    pkgs.writeTextFile {
      name = "tailscale-autoconnect.sh";
      executable = true;
      text = ''
        #!/bin/bash
        while [[ "$(${statusCommand})" == "NoState" ]]; do
          sleep 0.5
        done
        status=$(${statusCommand})
        if [[ "$status" == "NeedsLogin" || "$status" == "NeedsMachineAuth" ]]; then
          ${lib.getExe cfg.package} up --auth-key "$(cat ${authKeyFile})${params}" ${lib.escapeShellArgs cfg.extraUpFlags}
        fi
      '';
    };
in {
  options.dotnix.services.tailscale = {
    enable = lib.mkEnableOption "Enable module dotnix.services.tailscale";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs-unstable.tailscale;
      description = "Path to the tailscale binary";
    };

    authKeyParameters = lib.mkOption {
      type = lib.types.submodule {
        options = {
          ephemeral = lib.mkOption {
            type = lib.types.nullOr lib.types.bool;
            default = null;
            description = "Whether to register as an ephemeral node.";
          };
          preauthorized = lib.mkOption {
            type = lib.types.nullOr lib.types.bool;
            default = null;
            description = "Whether to skip manual device approval.";
          };
          baseURL = lib.mkOption {
            type = lib.types.nullOr lib.types.str;
            default = null;
            description = "Base URL for the Tailscale API.";
          };
        };
      };
      default = {};
      description = ''
        Extra parameters to pass after the auth key.
        See https://tailscale.com/kb/1215/oauth-clients#registering-new-nodes-using-oauth-credentials
      '';
    };

    extraUpFlags = lib.mkOption {
      description = ''
        Extra flags to pass to {command}`tailscale up`. Only applied if `authKeyFile` is specified.";
      '';
      type = lib.types.listOf lib.types.str;
      default = ["--advertise-tags=tag:dotnix"];
      example = ["--ssh"];
    };
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs-unstable; [
      tailscale
    ];

    services.tailscale =
      {
        enable = true;
      }
      // (
        if (!isDarwin)
        then {
          openFirewall = true;
          inherit authKeyFile;
          inherit (cfg) authKeyParameters extraUpFlags;
        }
        else {}
      );

    launchd = lib.mkIf pkgs.stdenv.isDarwin {
      daemons.tailscale-autoconnect = {
        command = "${autoConnectScript}";
        serviceConfig = {
          Label = "com.tailscale.tailscale-autoconnect";
          RunAtLoad = true;
        };
      };
    };
  };
}
