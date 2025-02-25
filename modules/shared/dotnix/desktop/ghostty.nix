{
  config,
  lib,
  pkgs,
  dotnix-constants,
  dotnix-utils,
  ...
}: let
  cfg = config.dotnix.desktop.ghostty;
  termCfg = config.dotnix.desktop.terminal;

  toConfigItem = key: value: {
    "${key}" = value;
  };

  # font-codepoint-map
  font-codepoint-map-settings =
    builtins.map
    (range: {font-codepoint-map = "${range}=${termCfg.nerdfont-family}";})
    dotnix-constants.constants.nerd-icon-ranges;

  simpleSettings =
    {
      inherit (termCfg) font-family font-size theme;
      command = termCfg.shell;
      working-directory = "home";
      clipboard-read = "allow";
      clipboard-write = "allow";
      copy-on-select = "clipboard";

      quick-terminal-position = "bottom";
      quick-terminal-screen = "main";
      quick-terminal-animation-duration = "0.5";
      quick-terminal-autohide = "false";

      macos-titlebar-style = "transparent";
      macos-titlebar-proxy-icon = "hidden";
      macos-option-as-alt = "true";
      macos-auto-secure-input = "false";

      font-thicken = "true";
      background-opacity = "0.9";
      background-blur-radius = "20";

      window-title-font-family = "Maple Mono NF CN";
    }
    // (
      if termCfg.adjust-cell-width != ""
      then {
        inherit (termCfg) adjust-cell-width;
      }
      else {}
    )
    // (
      if termCfg.adjust-cell-height != ""
      then {
        inherit (termCfg) adjust-cell-height;
      }
      else {}
    );

  keybindings = {
    "cmd+r" = "reload_config";
    "cmd+equal" = "increase_font_size:1";
    "cmd+minus" = "decrease_font_size:1";
    "cmd+backspace" = "reset_font_size";
    "cmd+v" = "paste_from_clipboard";
    "cmd+a" = "select_all";
    "cmd+n" = "new_tab";
    "cmd+shift+left_bracket" = "previous_tab";
    "cmd+shift+right_bracket" = "next_tab";
    "cmd+1" = "goto_tab:1";
    "cmd+2" = "goto_tab:2";
    "cmd+3" = "goto_tab:3";
    "cmd+4" = "goto_tab:4";
    "cmd+5" = "goto_tab:5";
    "cmd+6" = "goto_tab:6";
    "cmd+7" = "goto_tab:7";
    "cmd+8" = "goto_tab:8";
    "cmd+9" = "goto_tab:9";
    "cmd+d" = "new_split:right";
    "cmd+shift+d" = "new_split:down";
    "cmd+h" = "goto_split:left";
    "cmd+j" = "goto_split:bottom";
    "cmd+k" = "goto_split:top";
    "cmd+l" = "goto_split:right";
    "cmd+p" = "toggle_split_zoom";
    "cmd+left_bracket" = "goto_split:previous";
    "cmd+right_bracket" = "goto_split:next";
    "global:cmd+grave_accent" = "toggle_quick_terminal";
  };

  settings =
    (
      lib.attrsets.mapAttrsToList (key: value: toConfigItem key value) simpleSettings
    )
    ++ (
      if termCfg.map-nerdfont-ranges
      then font-codepoint-map-settings
      else []
    )
    ++ (
      builtins.map (feature: {font-feature = feature;}) termCfg.font-features
    )
    ++ (
      lib.attrsets.mapAttrsToList (key: value: toConfigItem "keybind" "${key}=${value}") keybindings
    );

  generateConfigLine = attrs: lib.attrsets.mapAttrsToList (key: value: "${key} = ${toString value}") attrs;
in {
  options.dotnix.desktop.ghostty = {
    enable = lib.mkEnableOption "Enable module dotnix.desktop.ghostty";
  };

  config = lib.mkIf cfg.enable {
    home-manager = dotnix-utils.hm.hmConfig {
      xdg.configFile = let
        configLines = builtins.map generateConfigLine settings;
        # concat lines
        configContent = lib.concatStringsSep "\n" (
          builtins.foldl' (x: y: x ++ y) [] configLines
        );
      in {
        "ghostty/config" = {
          source = pkgs.writeText "config" ''
            ${configContent}
          '';
          force = true;
        };
      };
    };
  };
}
