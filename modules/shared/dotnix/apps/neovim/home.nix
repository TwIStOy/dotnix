{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  nur-hawtian,
  ...
}: let
  user-dotpath = "${config.home.homeDirectory}/.dotvim";

  plugins = {
    inherit (nur-hawtian.packages.${pkgs.system}.vimPlugins) gh-actions-nvim fugit2-nvim;
    inherit (pkgs-unstable.vimPlugins) telescope-fzf-native-nvim;
    inherit (pkgs-unstable.vimPlugins) markdown-preview-nvim;
  };

  bins = with pkgs-unstable; {
    inherit fzf stylua lua-language-server statix;
    clangd = llvmPackages_17.clang-unwrapped;
    clang-format = llvmPackages_17.clang-unwrapped;
    inherit (python312Packages) black;
    inherit (pkgs) rustfmt;
    rust-analyzer = pkgs.rust-analyzer-nightly;
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
    python3.pkgs.pynvim
    nodePackages.neovim
    tree-sitter
    nixAwareNvimConfig
  ];

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
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
