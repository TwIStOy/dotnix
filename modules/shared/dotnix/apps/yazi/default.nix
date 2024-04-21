{
  config,
  lib,
  dotnix-utils,
  pkgs-unstable,
  ...
}: let
  cfg = config.dotnix.apps.yazi;
  yazi-plugins = [
    "smart-enter.yazi/init.lua"
  ];

  add-plugin = plugin: {
    "yazi/plugins/${plugin}".text =
      builtins.readFile ./plugins/${plugin};
  };

  useNvimAsOpenerFiles = [
    "*.json"
    "*.cpp"
    "*.lua"
    "*.toml"
    "*.yaml"
    "*.c"
    "*.rs"
    "*.ts"
    "*.nix"
    "justfile"
    "LICENSE"
    "flake.lock"
  ];
  nvimRules = lib.lists.forEach useNvimAsOpenerFiles (file: {
    name = file;
    use = "text";
  });
in {
  options.dotnix.apps.yazi = {
    enable = lib.mkEnableOption "Enable module dotnix.apps.yazi";
  };

  config = lib.mkIf cfg.enable {
    home-manager = dotnix-utils.hm.hmConfig {
      programs.yazi = {
        enable = true;
        package = pkgs-unstable.yazi;
        enableBashIntegration = true;
        enableFishIntegration = true;

        settings = {
          log = {
            enabled = true;
          };
          opener = {
            text = [
              {
                run = "nvim \"$@\"";
                block = true;
              }
            ];
          };
          open = {
            rules = nvimRules;
          };
          manager = {
            keymap = [
              {
                on = ["l"];
                run = "plugin --sync smart-enter";
                desc = "Enter the child directory, or open the file";
              }
            ];
          };
        };
      };

      # plugins
      xdg.configFile = lib.attrsets.mergeAttrsList (
        (lib.lists.forEach yazi-plugins add-plugin)
        ++ [
          {"yazi/init.lua".text = builtins.readFile ./init.lua;}
        ]
      );
    };
  };
}
