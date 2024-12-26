{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  nur-hawtian,
  inputs,
  ...
}: let
  user-dotpath = "${config.home.homeDirectory}/.dotvim";

  blinkPkgs = inputs.blink.packages.${pkgs.system};
  nurVimPlugins = nur-hawtian.packages.${pkgs.system}.vimPlugins;
  unstableVimPlugins = pkgs-unstable.vimPlugins;

  plugins = {
    inherit (nurVimPlugins) codesnap-nvim;
    inherit (unstableVimPlugins) telescope-fzf-native-nvim;
    inherit (unstableVimPlugins) avante-nvim;
    inherit (unstableVimPlugins) markdown-preview-nvim;
    inherit (unstableVimPlugins) rest-nvim;
    inherit (blinkPkgs) blink-cmp;
  };

  bins = {
    clangd = pkgs-unstable.clang-tools;
    clang-format = pkgs-unstable.llvmPackages_19.clang-unwrapped;
    inherit (pkgs-unstable.python312Packages) black;
    inherit (pkgs) rustfmt yaml-language-server libgit2 lua-language-server statix;
    inherit (pkgs-unstable) taplo beancount-language-server fzf stylua;
    rust-analyzer = pkgs.rust-analyzer-nightly;
    vscode-html-language-server = pkgs.vscode-langservers-extracted;
    vscode-eslint-language-server = pkgs.vscode-langservers-extracted;
    vscode-markdown-language-server = pkgs.vscode-langservers-extracted;
    vscode-json-language-server = pkgs.vscode-langservers-extracted;
    vscode-css-language-server = pkgs.vscode-langservers-extracted;
    jdtls = pkgs-unstable.jdt-language-server;
    xmllint = pkgs-unstable.libxml2;
  };

  libs = with pkgs-unstable; {
    inherit (luajitPackages) tiktoken_core magick;
  };

  nixAwareNvimConfig = pkgs.stdenv.mkDerivation {
    name = "nix-aware-nvim-config";

    buildInputs =
      (lib.mapAttrsToList (_: pkg: pkg) plugins)
      ++ (lib.mapAttrsToList (_: pkg: pkg) bins)
      ++ (lib.mapAttrsToList (_: pkg: pkg) libs);

    phases = ["installPhase"];

    nixAwareNvimConfigJson =
      pkgs.writeText
      "nixAwareNvimConfig.json"
      (builtins.toJSON {
        pkgs = plugins;
        bin = lib.mapAttrs (name: pkg: "${pkg}/bin/${name}") bins;
        inherit libs;
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
  home.packages =
    (with pkgs; [
      neovim-node-client
      tree-sitter
      nixAwareNvimConfig
    ])
    ++ (
      with pkgs-unstable; [
        python312Packages.pynvim
      ]
    );

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
