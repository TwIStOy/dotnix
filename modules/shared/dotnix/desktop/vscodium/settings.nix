{
  pkgs,
  pkgs-unstable,
  ...
}: {
  # Extensions
  "extensions.ignoreRecommendations" = true;

  # Workbench
  "workbench.colorTheme" = "Catppuccin Mocha";
  "workbench.iconTheme" = "catppuccin-perfect-mocha";
  "workbench.editor.highlightModifiedTabs" = true;
  "workbench.activityBar.location" = "top";

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
  "editor.formatOnSave" = true;

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

  # Language Specific
  "[cpp]" = {
  };
  "[rust]" = {
    "editor.rulers" = [100];
    "editor.tabSize" = 4;
  };
}
