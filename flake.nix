{
  description = "Wolf's MacOS Home Manager Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/release-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };

    treefmt-nix.url = "github:numtide/treefmt-nix";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    flake-utils.url = "github:numtide/flake-utils";
    nix-colors.url = "github:misterio77/nix-colors";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-neovim.url = "github:404Wolf/nix-neovim";
    dalleCLI.url = "github:404Wolf/DALLE-CLI";
    nixGpt.url = "github:404Wolf/nixified-gpt-cli";
    remarkable-connection-utility.url = "github:/404wolf/remarkable-connection-utility";
    remarkable-obsidian.url = "github:404Wolf/remarkable-obsidian";
    cartographcf.url = "github:404Wolf/CartographCF";

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    flake-utils,
    darwin,
    nix-homebrew,
    homebrew-bundle,
    homebrew-core,
    homebrew-cask,
    ...
  } @ inputs: let
    darwinSystem = "aarch64-darwin";
    pkgs-options = {
      system = darwinSystem;
      config = {allowUnfree = true;};
      permittedInsecurePackages = ["electron-25.9.0"];
    };

    pkgs = import nixpkgs (pkgs-options
      // {
        overlays = [
          (final: prev: {
            wrappedNvim = inputs.nix-neovim.packages.${darwinSystem}.default;
            dalleCLI = inputs.dalleCLI.packages.${darwinSystem}.default;
            nixGpt = inputs.nixGpt.packages.${darwinSystem}.default;
            rcu = inputs.remarkable-connection-utility.packages.${darwinSystem}.default;
            obsidian = inputs.remarkable-obsidian.packages.${darwinSystem}.obsidian;
            cartographcf = inputs.cartographcf.packages.${darwinSystem}.default;
            firefox-addons = inputs.firefox-addons.packages.${darwinSystem};
          })
          inputs.nur.overlays.default
        ];
      });

    utils = pkgs.callPackage ./utils.nix {};

    # Darwin-specific configurations
    darwinOutputs = {
      homeConfigurations.wolfmermelstein = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {
          inherit inputs utils;
          helpers = utils;
          nix-colors = inputs.nix-colors;
        };
        modules = [
          ./users/wolfmermelstein
        ];
      };

      darwinConfigurations = {
        default = darwin.lib.darwinSystem {
          system = darwinSystem;
          specialArgs = inputs;
          modules = [
            home-manager.darwinModules.home-manager
            nix-homebrew.darwinModules.nix-homebrew
            {
              nix-homebrew = {
                enable = true;
                user = "wolfmermelstein";
                taps = {
                  "homebrew/homebrew-core" = homebrew-core;
                  "homebrew/homebrew-cask" = homebrew-cask;
                  "homebrew/homebrew-bundle" = homebrew-bundle;
                };
                mutableTaps = false;
                autoMigrate = true;
              };
            }
            ./darwin.nix
          ];
        };
      };
    };

    # Cross-platform outputs using flake-utils
    crossPlatformOutputs = flake-utils.lib.eachDefaultSystem (system: {
      # Development shell
      devShell = let
        systemPkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in
        systemPkgs.mkShell {
          packages = with systemPkgs; [
            git
            nil
            alejandra
          ];
        };

      # Formatter configuration
      formatter = let
        systemPkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        treefmtconfig = inputs.treefmt-nix.lib.evalModule systemPkgs {
          projectRootFile = "flake.nix";
          programs.alejandra.enable = true;
          programs.shellcheck.enable = true;
          settings.formatter.shellcheck.excludes = [".envrc"];
        };
      in
        treefmtconfig.config.build.wrapper;
    });
  in
    darwinOutputs // crossPlatformOutputs;
}
