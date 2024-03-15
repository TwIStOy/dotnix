{
  config,
  lib,
  pkgs,
  dotnix-utils,
  ...
}: let
  inherit (dotnix-utils) enabled enableModules;
  cfg = config.dotnix.suits.term;
in {
  options.dotnix.suits.term = {
    enable = lib.mkEnableOption "Enable module dotnix.suits.term";
  };

  config = lib.mkIf cfg.enable {
    dotnix = {
      apps = enableModules [
        "eza"
        "fish"
        "neovim"
        "rime_ls"
        "starship"
        "tealdeer"
        "tmux"
        "yazi"
        "zoxide"
      ];

      hm.packages = with pkgs; [
        neofetch

        # decompress
        zip
        xz
        unzip
        p7zip

        # common tools
        delta
        (ripgrep.override {withPCRE2 = true;})
        hyperfine
        fd
        skim
        btop
        tokei
        ydict
        curl
        wget
        dig
        expect
        gnugrep
        gnused
        gawk
        jq
        yq-go

        xclip
        fswatch
      ];
    };

    home-manager = dotnix-utils.hm.hmConfig {
      programs.nix-index.enable = true;
    };
  };
}
