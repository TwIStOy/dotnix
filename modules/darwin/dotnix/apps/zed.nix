{
  config,
  lib,
  dotnix-utils,
  ...
}: let
  cfg = config.dotnix.apps.zed;

  extensions = [
    "macos-classic"
    "catppuccin"
    "xcode-themes"
    "nix"
    "lua"
    "kanagawa-themes"
  ];

  auto_install_extensions = builtins.foldl' (acc: ext: acc // {${ext} = true;}) {} extensions;
  auto_update_extensions = builtins.foldl' (acc: ext: acc // {${ext} = true;}) {} extensions;

  shared-settings = {
    language_models = {
      openai = {
        api_url = "https://api.gptsapi.net/v1";
      };
    };
    assistant = {
      version = "2";
      default_model = {
        model = "claude-3-5-sonnet";
        provider = "copilot_chat";
      };
    };
  };

  gen-settings = {
    buffer_font_size,
    ui_font_size,
  }: {
    theme = "Xcode Persentation Dark";
    auto_update = false;
    inherit auto_update_extensions;
    inherit auto_install_extensions;
    vim_mode = true;
    cursor_blink = false;
    relative_line_numbers = true;
    ui_font_family = "Readex Pro";
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
    inherit ui_font_size;
    scrollbar = {
      show = "never";
    };
    lsp = {
      "rust-analyzer" = {
        binary = {
          path_lookup = true;
        };
        initialization_options = {
          check = {command = "clippy";};
          imports = {
            granularity = {
              enforce = true;
              group = "crate";
            };
            prefix = "crate";
          };
          semanticHighlighting = {
            operator = {specialization = {enable = true;};};
            punctuation = {enable = true;};
          };
          files = {
            watcher = "server";
            excludeDirs = [".direnv" ".devenv"];
            watcherExclude = [".direnv" ".devenv"];
          };
        };
      };
      "nil" = {
        settings = {
          diagnostics = {
            ignored = ["unused_binding"];
          };
        };
        formatting = {
          command = ["alejandra"];
        };
        nix = {
          maxMemoryMB = 2 * 1024;
          flake = {
            autoArchive = true;
            autoEvalInputs = false;
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
      Nix = {
        language_servers = ["nil" "!nixd"];
      };
    };
    terminal = {
      shell = {
        program = "fish";
      };
      font_family = "MonaspiceAr Nerd Font";
    };
    load_direnv = "shell_hook";
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
    {
      context = "Editor && vim_mode == normal && !menu";
      bindings = {
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

    ui_font_size = lib.mkOption {
      type = lib.types.int;
      default = 16;
      description = ''
        The font size of the UI.
      '';
    };
  };

  config = lib.mkIf cfg.enable {
    homebrew = {
      casks = ["zed@preview"];
    };

    home-manager = dotnix-utils.hm.hmConfig {
      xdg.configFile."zed/settings.json" = {
        text = builtins.toJSON ((gen-settings {
            inherit (cfg) buffer_font_size ui_font_size;
          })
          // shared-settings);
        force = true;
      };
      xdg.configFile."zed/keymap.json" = {
        text = builtins.toJSON keymaps;
        force = true;
      };
    };
  };
}
