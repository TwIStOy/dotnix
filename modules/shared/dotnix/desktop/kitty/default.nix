{
  config,
  lib,
  dotnix-utils,
  pkgs-unstable,
  ...
}: let
  cfg = config.dotnix.desktop.kitty;

  font-utils = import ./font-utils.nix;

  inherit (font-utils) to-font-config map-nerd-icon-ranges;

  maple-config = to-font-config {
    family = "MapleMono-NF-CN";
    variants = [
      "Bold"
      "BoldItalic"
      "ExtraBold"
      "ExtraBoldItalic"
      "ExtraLight"
      "ExtraLightItalic"
      "Italic"
      "Light"
      "LightItalic"
      "Medium"
      "MediumItalic"
      "Regular"
      "SemiBold"
      "SemiBoldItalic"
      "Thin"
      "ThinItalic"
    ];
    features = "+ss01 +ss02";
  };

  monolisa-config = to-font-config {
    family = "";
    variants = [
      "MonoLisa-Bold"
      "MonoLisa-BoldItalic"
      "MonoLisa-Regular"
      "MonoLisa-RegularItalic"
      "MonoLisaBlack-Regular"
      "MonoLisaBlack-Italic"
      "MonoLisaExtraBold-Regular"
      "MonoLisaExtraBold-Italic"
      "MonoLisaExtraLight-Regular"
      "MonoLisaExtraLight-Italic"
      "MonoLisaLight-Regular"
      "MonoLisaLight-Italic"
      "MonoLisaMedium-Regular"
      "MonoLisaMedium-Italic"
      "MonoLisaSemiBold-Regular"
      "MonoLisaSemiBold-Italic"
      "MonoLisaThin-Regular"
      "MonoLisaThin-Italic"
    ];
    features = "+ss01 +ss07 +ss11 -calt +ss09 +ss02 +ss14 +ss16";
  };

  symbol-map-nerd-icons = map-nerd-icon-ranges {
    family = "Symbols Nerd Font";
  };
in {
  options.dotnix.desktop.kitty = {
    enable = lib.mkEnableOption "Enable kitty terminal";
  };

  config = lib.mkIf cfg.enable {
    home-manager = dotnix-utils.hm.hmConfig {
      programs.kitty = {
        enable = true;
        package = pkgs-unstable.kitty;

        theme = "Catppuccin-Mocha";
        settings = {
          font_family = "Maple Mono NF CN";

          disable_ligatures = "never";
          share_connections = "yes";
          scrollback_lines = "10000";

          mouse_hide_wait = "0";
          copy_on_select = "yes";
          terminal_select_modifiers = "alt";

          input_delay = 1;
          repaint_delay = 8;
          sync_to_monitor = "no";

          enable_audio_bell = "no";
          visual_bell_duration = "0";
          window_alert_on_bell = "no";
          bell_on_tab = "no";
          command_on_bell = "none";

          remember_window_size = "yes";
          enabled_layouts = "*";

          tab_bar_edge = "bottom";
          tab_bar_style = "powerline";
          tab_powerline_style = "slanted";
          active_tab_title_template = "{index}: {title}";
          active_tab_font_style = "bold-italic";
          inactive_tab_font_style = "normal";

          macos_titlebar_color = "system";
          macos_option_as_alt = "yes";
          macos_quit_when_last_window_closed = "yes";
          macos_colorspace = "srgb";

          term = "xterm-256color";

          kitty_mod = "cmd";
          clear_all_shortcuts = "yes";
          shell = "/run/current-system/sw/bin/fish --login";

          clipboard_control = "write-clipboard write-primary read-clipboard read-primary";

          allow_remote_control = "yes";
        };

        keybindings = {
          "cmd+d" = "combine : new_window : next_window";
          "cmd+l" = "next_layout";
          "cmd+n" = "new_tab !neighbor";
          "cmd+shift+n" = "new_os_window";
          "cmd+b>j" = "new_tab !neighbor ssh jumpserver";
          "cmd+b>d" = "new_tab !neighbor ssh dev4";
          "cmd+[" = "previous_window";
          "cmd+]" = "next_window";
          "cmd+shift+[" = "previous_tab";
          "cmd+shift+]" = "next_tab";
          "cmd+w" = "close_tab";
          "cmd+1" = "goto_tab 1";
          "cmd+2" = "goto_tab 2";
          "cmd+3" = "goto_tab 3";
          "cmd+4" = "goto_tab 4";
          "cmd+5" = "goto_tab 5";
          "cmd+6" = "goto_tab 6";
          "cmd+7" = "goto_tab 7";
          "cmd+8" = "goto_tab 8";
          "cmd+9" = "goto_tab 9";
          "cmd+`" = "kitty_shell show";

          "cmd+v" = "paste_from_clipboard";
          "cmd+c" = "copy_to_clipboard";

          "cmd+s" = "send_text all \\xAA";
          "cmd+." = "send_text all \\xAB";
          "cmd+k" = "send_text all \\xAC";
          "cmd+o" = "send_text all \\xAD";

          "cmd+equal" = "change_font_size all +2.0";
          "cmd+minus" = "change_font_size all -2.0";
          "cmd+backspace" = "change_font_size all 0";

          "cmd+r" = "load_config_file";
        };

        extraConfig = ''
          ${maple-config}
          ${monolisa-config}

          font_features Iosevka +ss07 cv49=16 cv94=1 VXLA=2 VXLC=2 cv34=12 cv31=13
          font_features Iosevka-Semibold +ss07 cv49=16 cv94=1 VXLA=2 VXLC=2 cv34=12 cv31=13
          font_features Iosevka-Italic +ss07 cv49=16 cv94=1 VXLA=2 VXLC=2 cv34=12 cv36=27 cv32=2 cv25=27 cv31=13
          font_features Iosevka-Oblique +ss07 cv49=16 cv94=1 VXLA=2 VXLC=2 cv34=12 cv36=27 cv32=2 cv25=27 cv31=13
          font_features Iosevka-Bold +ss07 cv49=16 cv94=1 VXLA=2 VXLC=2 cv34=12 cv31=13
          font_features Iosevka-Bold-Italic +ss07 cv49=16 cv94=1 VXLA=2 VXLC=2 cv34=12 cv36=27 cv32=2 cv25=27 cv31=13
          font_features Iosevka-Bold-Oblique +ss07 cv49=16 cv94=1 VXLA=2 VXLC=2 cv34=12 cv36=27 cv32=2 cv25=27 cv31=13


          modify_font underline_position 22
          modify_font cell_width 90%
          modify_font baseline 0
        '';
      };
    };
  };
}
