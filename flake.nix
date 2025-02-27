{
  description = "Wolf's MacOS Home Manager Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/release-24.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
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
    ...
  } @ inputs:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs-options = {
        inherit system;
        config = {allowUnfree = true;};
        permittedInsecurePackages = ["electron-25.9.0"];
      };

      pkgs = import nixpkgs (pkgs-options
        // {
          overlays = [
            (final: prev: {
              wrappedNvim = inputs.nix-neovim.packages.${system}.default;
              dalleCLI = inputs.dalleCLI.packages.${system}.default;
              nixGpt = inputs.nixGpt.packages.${system}.default;
              rcu = inputs.remarkable-connection-utility.packages.${system}.default;
              obsidian = inputs.remarkable-obsidian.packages.${system}.obsidian;
              cartographcf = inputs.cartographcf.packages.${system}.default;
              firefox-addons = inputs.firefox-addons.packages.${system};
            })
            inputs.nur.overlays.default
          ];
        });

      utils = pkgs.callPackage ./utils.nix {};
    in {
      # Home Manager configuration
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

      # Development shell
      devShell = pkgs.mkShell {
        packages = with pkgs; [
          wrappedNvim
          nil
          git
          nix
          home-manager
        ];
      };

      # Formatter configuration
      formatter = let
        treefmtconfig = inputs.treefmt-nix.lib.evalModule pkgs {
          projectRootFile = "flake.nix";
          programs.alejandra.enable = true;
          programs.shellcheck.enable = true;
          settings.formatter.shellcheck.excludes = [".envrc"];
        };
      in
        treefmtconfig.config.build.wrapper;
    });
}
