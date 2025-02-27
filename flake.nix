{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";

    nix-ld.url = "github:Mic92/nix-ld";
    # this line assume that you also have nixpkgs as an input
    nix-ld.inputs.nixpkgs.follows = "nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    # unused ATM
    impermanence.url = "github:nix-community/impermanence";
    nix-colors.url = "github:misterio77/nix-colors";
    # end of unused

    xremap-flake.url = "github:xremap/nix-flake";

    nixvim = {
      url = "github:nix-community/nixvim";
      # unfollowing nixpkgs for compatibility with bash lsp
      #inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprwn-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser.url ="github:0xc000022070/zen-browser-flake"; # OLD: "github:MarceColl/zen-browser-flake";
    # hyprland-plugins = {
    #   url = "github:hyprwm/hyprland-plugins";
    #   inputs.hyprland.follows = "hyprland";
    # };

    devenv.url = "github:cachix/devenv";
  };
  outputs = {
    self,
    nixpkgs,
    nix-ld,
    home-manager,
    devenv,
    hardware,
    nixos-hardware,
    ...
  } @ inputs: let
    inherit (self) outputs;
    # supported systems
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    # function generates an attribute by calling a function passed to it, with each system as an argument
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    # custom pkgs
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

    # declare alejandra as available formatter for nix fmt
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};

    # reusable nixos modules
    nixosModules = import ./modules/nixos;

    # reuable homemanager modules
    homeManagerModules = import ./modules/home-manager;

    # Lets begin the nixos configuration entrypoint

    nixosConfigurations = {
      # add entry for cuttlefish
      bigfin = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./nixos/bigfin/configuration.nix
        ];
      };
      cuttlefish = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./nixos/cuttlefish/configuration.nix
          nix-ld.nixosModules.nix-ld

          # The module in this repository defines a new module under (programs.nix-ld.dev) instead of (programs.nix-ld)
          # to not collide with the nixpkgs version.
          { programs.nix-ld.dev.enable = true; }
          nixos-hardware.nixosModules.framework-13-7040-amd
        ];
      };
    };
  };
}
