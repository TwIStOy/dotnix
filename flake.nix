{
  description = "Dotnix: hawtian's nix configuration for both macos and linux";

  outputs = {self, ...} @ inputs: let
    inherit (inputs) flake-utils nixpkgs nixpkgs-unstable;

    dotnix-constants = import ./constants.nix;
    dotnix-constants-work = import ./constants-work.nix;
    dotnix-utils = import ./lib {
      inherit inputs dotnix-constants;
    };
    dotnix-utils-work = import ./lib {
      inherit inputs;
      dotnix-constants = dotnix-constants-work;
    };

    mkSystemModule = import ./modules/mkSystem.nix (
      {
        inherit self inputs dotnix-constants dotnix-constants-work dotnix-utils dotnix-utils-work;
      }
      // inputs
    );

    inherit (mkSystemModule) mkSystem mkWorkSystem;

    formatter = flake-utils.lib.eachDefaultSystem (system: {
      formatter = nixpkgs-unstable.legacyPackages.${system}.alejandra;
    });

    hostsConfiguration = import ./hosts {
      inherit (inputs) flake-utils;
      inherit mkSystem mkWorkSystem;
    };

    templates = {
      templates.devenv = {
        path = ./templates/devenv;
        description = "devenv templates";
      };
    };

    checks = flake-utils.lib.eachDefaultSystem (system: {
      checks.pre-commit-check =
        inputs.pre-commit-hooks.lib.${system}.run
        {
          src = ./.;
          hooks = {
            actionlint.enable = true;

            statix = {
              enable = true;
            };

            alejandra = {
              enable = true;
              excludes = [
                "hardware-configuration.*.nix"
                ".*vim-template.*"
              ];
            };
          };

          settings = {
            # Work around for `statix`,
            # issue: https://github.com/cachix/pre-commit-hooks.nix/issues/288
            statix.ignore = [
              "hardware-configuration.nix"
              ".vim-template:*.nix"
              ".vim-template:default.nix"
            ];
          };
        };
    });
  in
    nixpkgs.lib.attrsets.mergeAttrsList [
      hostsConfiguration
      formatter
      templates
      checks
    ];

  inputs = {
    # Official NixOS package source, using nixos's stable branch by default
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable-small";

    flake-utils.url = "github:numtide/flake-utils";

    # for macos
    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-darwin";
    };
    nixpkgs-darwin.url = "github:nixos/nixpkgs/nixpkgs-24.05-darwin";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    # home-manager, used for managing user configuration
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur-hawtian = {
      url = "github:TwIStOy/nur-packages";
      inputs = {
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs-unstable";
      };
    };

    secrets-hawtian = {
      url = "git+ssh://git@github.com/TwIStOy/nix-secret.git?shallow=1";
      flake = false;
    };

    # add git hooks to format nix code before commit
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Secrets management
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    # devenv, construct a development environment easily
    devenv.url = "github:cachix/devenv";

    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # fix vscode server on nixos
    vscode-server = {
      url = "github:nix-community/nixos-vscode-server";
      inputs = {
        flake-utils.follows = "flake-utils";
        nixpkgs.follows = "nixpkgs";
      };
    };

    # use more vscode extensions
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    # for vim-plugin: blink.cmp
    blink.url = "github:Saghen/blink.cmp";
  };

  nixConfig = {
    extra-substituters = [
      "https://devenv.cachix.org"
    ];
    extra-trusted-public-keys = [
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
    ];
  };
}
