{
  config,
  lib,
  dotnix-utils,
  pkgs-unstable,
  ...
}: let
  cfg = config.dotnix.desktop.kitty;
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
          font_features MapleMono-NF-CN-Bold +ss01 +ss02
          font_features MapleMono-NF-CN-BoldItalic +ss01 +ss02
          font_features MapleMono-NF-CN-ExtraBold +ss01 +ss02
          font_features MapleMono-NF-CN-ExtraBoldItalic +ss01 +ss02
          font_features MapleMono-NF-CN-ExtraLight +ss01 +ss02
          font_features MapleMono-NF-CN-ExtraLightItalic +ss01 +ss02
          font_features MapleMono-NF-CN-Italic +ss01 +ss02
          font_features MapleMono-NF-CN-Light +ss01 +ss02
          font_features MapleMono-NF-CN-LightItalic +ss01 +ss02
          font_features MapleMono-NF-CN-Medium +ss01 +ss02
          font_features MapleMono-NF-CN-MediumItalic +ss01 +ss02
          font_features MapleMono-NF-CN-Regular +ss01 +ss02
          font_features MapleMono-NF-CN-SemiBold +ss01 +ss02
          font_features MapleMono-NF-CN-SemiBoldItalic +ss01 +ss02
          font_features MapleMono-NF-CN-Thin +ss01 +ss02
          font_features MapleMono-NF-CN-ThinItalic +ss01 +ss02

          font_features Iosevka +ss07 cv49=16 cv94=1 VXLA=2 VXLC=2 cv34=12 cv31=13
          font_features Iosevka-Semibold +ss07 cv49=16 cv94=1 VXLA=2 VXLC=2 cv34=12 cv31=13
          font_features Iosevka-Italic +ss07 cv49=16 cv94=1 VXLA=2 VXLC=2 cv34=12 cv36=27 cv32=2 cv25=27 cv31=13
          font_features Iosevka-Oblique +ss07 cv49=16 cv94=1 VXLA=2 VXLC=2 cv34=12 cv36=27 cv32=2 cv25=27 cv31=13
          font_features Iosevka-Bold +ss07 cv49=16 cv94=1 VXLA=2 VXLC=2 cv34=12 cv31=13
          font_features Iosevka-Bold-Italic +ss07 cv49=16 cv94=1 VXLA=2 VXLC=2 cv34=12 cv36=27 cv32=2 cv25=27 cv31=13
          font_features Iosevka-Bold-Oblique +ss07 cv49=16 cv94=1 VXLA=2 VXLC=2 cv34=12 cv36=27 cv32=2 cv25=27 cv31=13

          font_features MonoLisaBlack-Regular      +ss01 +ss07 +ss11 -calt +ss09 +ss02 +ss14 +ss16
          font_features MonoLisaBlack-Italic       +ss01 +ss07 +ss11 -calt +ss09 +ss02 +ss14 +ss16
          font_features MonoLisa-Bold              +ss01 +ss07 +ss11 -calt +ss09 +ss02 +ss14 +ss16
          font_features MonoLisa-BoldItalic        +ss01 +ss07 +ss11 -calt +ss09 +ss02 +ss14 +ss16
          font_features MonoLisaExtraBold-Regular  +ss01 +ss07 +ss11 -calt +ss09 +ss02 +ss14 +ss16
          font_features MonoLisaExtraBold-Italic   +ss01 +ss07 +ss11 -calt +ss09 +ss02 +ss14 +ss16
          font_features MonoLisaExtraLight-Regular +ss01 +ss07 +ss11 -calt +ss09 +ss02 +ss14 +ss16
          font_features MonoLisaExtraLight-Italic  +ss01 +ss07 +ss11 -calt +ss09 +ss02 +ss14 +ss16
          font_features MonoLisaLight-Regular      +ss01 +ss07 +ss11 -calt +ss09 +ss02 +ss14 +ss16
          font_features MonoLisaLight-Italic       +ss01 +ss07 +ss11 -calt +ss09 +ss02 +ss14 +ss16
          font_features MonoLisaMedium-Regular     +ss01 +ss07 +ss11 -calt +ss09 +ss02 +ss14 +ss16
          font_features MonoLisaMedium-Italic      +ss01 +ss07 +ss11 -calt +ss09 +ss02 +ss14 +ss16
          font_features MonoLisa-Regular           +ss01 +ss07 +ss11 -calt +ss09 +ss02 +ss14 +ss16
          font_features MonoLisa-RegularItalic     +ss01 +ss07 +ss11 -calt +ss09 +ss02 +ss14 +ss16
          font_features MonoLisaSemiBold-Regular   +ss01 +ss07 +ss11 -calt +ss09 +ss02 +ss14 +ss16
          font_features MonoLisaSemiBold-Italic    +ss01 +ss07 +ss11 -calt +ss09 +ss02 +ss14 +ss16
          font_features MonoLisaThin-Regular       +ss01 +ss07 +ss11 -calt +ss09 +ss02 +ss14 +ss16
          font_features MonoLisaThin-Italic        +ss01 +ss07 +ss11 -calt +ss09 +ss02 +ss14 +ss16

          modify_font underline_position 22
          modify_font cell_width 90%
          modify_font baseline 0
        '';

        # extraConfig = ''
        #
        #   # Seti-UI + Custom
        #   symbol_map U+E5FA-U+E6FF Symbols Nerd Font
        #
        #   # Heavy Angle Brackets
        #   symbol_map U+276C-U+2771 Symbols Nerd Font
        #
        #   # Box Drawing
        #   symbol_map U+2500-U+259F Symbols Nerd Font
        #
        #   # Devicons
        #   symbol_map U+E700-U+E7C5 Symbols Nerd Font
        #
        #   # Powerline Symbols
        #   symbol_map U+E0A0-U+E0A2,U+E0B0-U+E0B3 Symbols Nerd Font
        #   # Powerline Extra Symbols
        #   symbol_map U+E0A3,U+E0B4-U+E0C8,U+E0CA,U+E0CC-U+E0D4,U+2630 Symbols Nerd Font
        #
        #   # Pomicons
        #   symbol_map U+E000-U+E00A Symbols Nerd Font
        #
        #   # Font Awesome
        #   symbol_map U+F000-U+F2E0 Symbols Nerd Font
        #
        #   # Font Awesome Extension
        #   symbol_map U+E200-U+E2A9 Symbols Nerd Font
        #
        #   # Material Design Icons
        #   symbol_map U+F0001-U+F1AF0 Symbols Nerd Font
        #
        #   # Power symbols
        #   symbol_map U+23FB-U+23FE,U+2B58 Symbols Nerd Font
        #
        #   # Weather
        #   symbol_map U+E300-U+E3EB Symbols Nerd Font
        #
        #   # Octicons
        #   symbol_map U+F400-U+F505,U+2665,U+26A1,U+F4A9-U+F532,U+EA60-U+EBEB Symbols Nerd Font
        #
        #   # Font Logos
        #   symbol_map U+F300-U+F32F Symbols Nerd Font
        # '';
      };
    };
  };
}
