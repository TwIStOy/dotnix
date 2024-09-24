{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  nur-hawtian,
  ...
}: let
  user-dotpath = "${config.home.homeDirectory}/.dotvim";

  nurVimPlugins = nur-hawtian.packages.${pkgs.system}.vimPlugins;
  unstableVimPlugins = pkgs-unstable.vimPlugins;

  plugins = {
    inherit (nurVimPlugins) gh-actions-nvim fugit2-nvim codesnap-nvim avante-nvim;
    inherit (unstableVimPlugins) telescope-fzf-native-nvim;
    inherit (unstableVimPlugins) markdown-preview-nvim;
    inherit (unstableVimPlugins) rest-nvim;
  };

  bins = with pkgs-unstable; {
    inherit fzf stylua lua-language-server statix;
    clangd = llvmPackages_18.clang-unwrapped;
    clang-format = llvmPackages_18.clang-unwrapped;
    inherit (pkgs-unstable.python312Packages) black;
    inherit (pkgs) rustfmt yaml-language-server libgit2;
    inherit (pkgs-unstable) taplo;
    rust-analyzer = pkgs.rust-analyzer-nightly;
    vscode-html-language-server = pkgs.vscode-langservers-extracted;
    vscode-eslint-language-server = pkgs.vscode-langservers-extracted;
    vscode-markdown-language-server = pkgs.vscode-langservers-extracted;
    vscode-json-language-server = pkgs.vscode-langservers-extracted;
    vscode-css-language-server = pkgs.vscode-langservers-extracted;
    jdtls = jdt-language-server;
    xmllint = libxml2;
  };

  nixAwareNvimConfig = pkgs.stdenv.mkDerivation {
    name = "nix-aware-nvim-config";

    buildInputs =
      (lib.mapAttrsToList (_: pkg: pkg) plugins)
      ++ (lib.mapAttrsToList (_: pkg: pkg) bins);

    phases = ["installPhase"];

    nixAwareNvimConfigJson =
      pkgs.writeText
      "nixAwareNvimConfig.json"
      (builtins.toJSON {
        pkgs = plugins;
        bin = lib.mapAttrs (name: pkg: "${pkg}/bin/${name}") bins;
        try_nix_only = true;
      });

    installPhase = ''
      mkdir -p $out
      cp $nixAwareNvimConfigJson $out/nix-aware.json
    '';
  };

  init-dora = ''
    vim.loader.enable()
    local dotpath = "${user-dotpath}"
    vim.opt.rtp:prepend(dotpath)
    require("dotvim.bootstrap").setup()
  '';
in {
  home.packages = with pkgs; [
    pkgs-unstable.python312Packages.pynvim
    nodePackages.neovim
    tree-sitter
    nixAwareNvimConfig
  ];

  programs.neovim = {
    enable = true;
    package = pkgs-unstable.neovim;
    plugins = builtins.attrValues plugins;
  };

  xdg.configFile = {
    "nvim/init.lua" = {
      text = init-dora;
      force = true;
    };

    "nvim/nix-aware.json" = {
      source = "${nixAwareNvimConfig}/nix-aware.json";
      force = true;
    };
  };
}
