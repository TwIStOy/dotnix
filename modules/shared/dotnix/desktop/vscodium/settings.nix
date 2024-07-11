{
  pkgs,
  pkgs-unstable,
  ...
}: {
  # Extensions
  "extensions.ignoreRecommendations" = true;
  "extensions.experimental.affinity" = {
    "vscodevim.vim" = 1;
  };

  # Workbench
  "workbench.colorTheme" = "Catppuccin Mocha";
  "workbench.iconTheme" = "catppuccin-perfect-mocha";
  "workbench.editor.highlightModifiedTabs" = true;
  "workbench.activityBar.location" = "top";
  "workbench.tree.renderIndentGuides" = "none";

  # Editor
  "editor.fontSize" = 18;
  "editor.rulers" = [80];
  "editor.tabSize" = 2;
  "editor.fontFamily" = "'MonoLisa', Menlo, Monaco, 'Courier New', monospace";
  "editor.fontLigatures" = "'calt' off, 'liga' on, 'ss01' on, 'ss07' on, 'ss09' on, 'ss11' on, 'ss16' on, 'ss18' on";
  "editor.minimap.enabled" = false;
  "editor.lineNumbers" = "relative";
  "editor.inlineSuggest.enabled" = true;
  "editor.inlayHints.enabled" = "off";
  "editor.formatOnSave" = false;
  "editor.guides.indentation" = false;

  # Explorer
  "explorer.confirmDragAndDrop" = false;
  "explorer.autoReveal" = false;
  "explorer.confirmDelete" = false;

  # Git
  "git.confirmSync" = false;
  "git.enableSmartCommit" = true;
  "git.openRepositoryInParentFolders" = "never";
  "merge-conflict.autoNavigateNextConflict.enabled" = true;

  # xaver.clang-format
  "clang-format.executable" = "${pkgs-unstable.llvmPackages_18.clang-unwrapped}/bin/clang-format";

  # llvm-vs-code-extensions.vscode-clangd
  "clangd.arguments" = [
    "--clang-tidy"
    "--background-index"
    "--background-index-priority=normal"
    "--ranking-model=decision_forest"
    "--completion-style=detailed"
    "--header-insertion=iwyu"
    "--limit-references=100"
    "--limit-results=100"
    "--include-cleaner-stdlib"
    "--all-scopes-completion"
    "-j=20"
  ];

  # rust-lang.rust-analyzer
  "rust-analyzer.inlayHints.parameterHints.enable" = false;
  "rust-analyzer.inlayHints.typeHints.enable" = false;
  "rust-analyzer.rustfmt.rangeFormatting.enable" = true;
  "rust-analyzer.check.command" = "clippy";
  "rust-analyzer.checkOnSave" = true;
  "rust-analyzer.lens.enable" = false;
  "rust-analyzer.restartServerOnConfigChange" = true;
  "rust-analyzer.server.path" = "rust-analyzer";

  # jnoortheen.nix-ide
  "nix.serverPath" = "${pkgs.nil}/bin/nil";
  "nix.enableLanguageServer" = true;

  # github.copilot
  "github.copilot.enable" = {
    "*" = true;
    "plaintext" = true;
    "markdown" = false;
    "scminput" = false;
    "yaml" = false;
  };

  # vscodevim.vim
  "vim.incsearch" = true;
  "vim.hlsearch" = true;
  "vim.useCtrlKeys" = true;
  "vim.leader" = "<space>";
  "vim.useSystemClipboard" = false;
  "vim.surround" = true;
  "vim.insertModeKeyBindings" = [
    #     {
    #       "before": ["j", "j"],
    #       "after": ["<Esc>"]
    #     }
  ];
  "vim.normalModeKeyBindingsNonRecursive" = [
    {
      before = ["<leader>" "f" "t"];
      commands = [
        "workbench.files.action.showActiveFileInExplorer"
      ];
    }
    #     {
    #       "before": ["<leader>", "d"],
    #       "after": ["d", "d"]
    #     },
    #     {
    #       "before": ["<C-n>"],
    #       "commands": [":nohl"]
    #     },
    #     {
    #       "before": ["K"],
    #       "commands": ["lineBreakInsert"],
    #       "silent": true
    #     }
  ];
  "vim.handleKeys" = {
    #     "<C-a>": false,
    #     "<C-f>": false
  };

  # Language Specific
  "[cpp]" = {
  };
  "[rust]" = {
    "editor.rulers" = [100];
    "editor.tabSize" = 4;
  };
}
