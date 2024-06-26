{
  config,
  lib,
  dotnix-utils,
  ...
}: let
  cfg = config.dotnix.apps.zed;

  gen-settings = {buffer_font_size}: {
    theme = "Catppuccin Macchiato - No Italics";
    auto_update = false;
    auto_update_extensions = {
      "catppuccin" = false;
      "nix" = true;
    };
    auto_install_extensions = {
      "catppuccin" = true;
      "nix" = true;
    };
    vim_mode = true;
    cursor_blink = false;
    relative_line_numbers = true;
    ui_font_family = "Akzidenz-Grotesk BQ";
    buffer_font_family = "MonoLisa Variable";
    preferred_line_length = 80;
    buffer_font_features = {
      calt = false;
      ss01 = true;
      ss07 = true;
      ss09 = true;
      ss11 = true;
      ss16 = true;
      ss18 = true;
    };
    inherit buffer_font_size;
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
    git = {
      inline_blame = {
        enabled = false;
      };
    };
    languages = {
      Python = {
        indent_guides = {
          enabled = true;
          coloring = "indent_aware";
        };
      };
      Rust = {
        preferred_line_length = 100;
      };
    };
    terminal = {
      shell = {
        program = "fish";
      };
      font_family = "MonaspiceAr Nerd Font";
    };
    assistant = {
      version = "1";
      provider = {
        name = "openai";
        type = "openai";
        default_model = "gpt-4o";
        api_url = "https://api.gptsapi.net";
      };
    };
    # TODO(Hawtian Wang): setup OPENAI_API_KEY later
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

    buffer_font_size = lib.mkOption {
      type = lib.types.int;
      default = 20;
      description = ''
        The font size of the buffer.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    homebrew = {
      casks = ["zed@preview"];
    };

    home-manager = dotnix-utils.hm.hmConfig {
      xdg.configFile."zed/settings.json" = {
        text = builtins.toJSON (gen-settings {
          inherit (cfg) buffer_font_size;
        });
        force = true;
      };
      xdg.configFile."zed/keymap.json" = {
        text = builtins.toJSON keymaps;
        force = true;
      };
    };
  };
}
