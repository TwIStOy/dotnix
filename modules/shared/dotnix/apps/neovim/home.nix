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
    inherit (nurVimPlugins) gh-actions-nvim fugit2-nvim codesnap-nvim avante-nvim;
    inherit (unstableVimPlugins) telescope-fzf-native-nvim;
    inherit (unstableVimPlugins) markdown-preview-nvim;
    inherit (unstableVimPlugins) rest-nvim;
    inherit (blinkPkgs) blink-cmp;
  };

  bins = with pkgs-unstable; {
    inherit fzf stylua lua-language-server statix;
    clangd = clang-tools;
    clang-format = llvmPackages_19.clang-unwrapped;
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
      nodePackages.neovim
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
