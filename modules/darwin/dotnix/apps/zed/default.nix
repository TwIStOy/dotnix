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
    "mcp-server-github"
  ];

  auto_install_extensions = builtins.foldl' (acc: ext: acc // {${ext} = true;}) {} extensions;
  auto_update_extensions = builtins.foldl' (acc: ext: acc // {${ext} = true;}) {} extensions;

  shared-settings = {
    agent = {
      always_allow_tool_actions = true;
    };
    context_servers = {
      mcp-server-github = {
        source = "extension";
        enabled = true;
        settings = {
          github_personal_access_token = "\${cmd:cat /run/agenix/github-cli-access-token}";
        };
      };
    };
  };

  gen-settings = {
    buffer_font_size,
    ui_font_size,
  }: {
    theme = "Catppuccin Macchiato";
    icon_theme = "Catppuccin Frappé";
    auto_update = false;
    inherit auto_update_extensions;
    inherit auto_install_extensions;
    vim_mode = true;
    vim = {
      use_system_clipboard = "on_yank";
    };
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
    command_aliases = {
      W = "w";
      Wq = "wq";
      WQ = "wq";
      Q = "q";
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
    load_direnv = "direct";
    format_on_save = false;
  };
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

    ssh_connections = lib.mkOption {
      type = lib.types.listOf lib.types.anything;
      default = [];
      description = ''
        SSH connections to be used by Zed.
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
        text = builtins.readFile ./keymap.json;
        force = true;
      };
    };
  };
}
