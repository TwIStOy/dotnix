{
  config,
  lib,
  dotnix-utils,
  ...
}: let
  cfg = config.dotnix.apps.zed;

  settings = {
    theme = "Catppuccin Macchiato - No Italics";
    vim_mode = true;
    cursor_blink = false;
    relative_line_numbers = true;
    ui_font_family = "Iosevka";
    buffer_font_family = "MonoLisa Variable";
    buffer_font_features = {
      calt = false;
      ss01 = true;
      ss07 = true;
      ss09 = true;
      ss11 = true;
      ss16 = true;
      ss18 = true;
    };
    buffer_font_size = 20;
    scrollbar = {
      show = "never";
    };
    lsp = {
      "rust-analyzer" = {
        binary = {
          path_lookup = true;
        };
        initialization_options = {
          check = {
            command = "clippy";
          };
        };
      };
    };
    current_line_highlight = "line";
    indent_guides = {
      enabled = false;
    };
    auto_install_extensions = [
      "catppuccin"
    ];
  };

  keymaps = [
    {
      context = "Editor && VimControl && !VimWaiting && !menu";
      bindings = {
        "[ c" = "editor::GoToPrevDiagnostic";
        "] c" = "editor::GoToDiagnostic";
      };
    }
    {
      context = "Editor && vim_mode == insert && !menu";
      bindings = {
        "ctrl-l" = "editor::AcceptInlineCompletion";
      };
    }
  ];
in {
  options.dotnix.apps.zed = {
    enable = lib.mkEnableOption "Zed";
  };

  config = lib.mkIf cfg.enable {
    homebrew = {
      casks = ["zed@preview"];
    };

    home-manager = dotnix-utils.hm.hmConfig {
      xdg.configFile."zed/config.json" = {
        text = builtins.toJSON settings;
        force = true;
      };
      xdg.configFile."zed/keymap.json" = {
        text = builtins.toJSON keymaps;
        force = true;
      };
    };
  };
}
