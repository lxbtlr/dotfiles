{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    hardware.url = "github:nixos/nixos-hardware";

    # unused ATM
    impermanence.url = "github:nix-community/impermanence";
    nix-colors.url = "github:misterio77/nix-colors";
    # end of unused

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwn/hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprwn-contrib = {
      url = "github:hyprwn/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "github:hyprwn/hyprland-plugins";
      inputs.nixpkgs.follows = "hyprland";
    };

    devenv.url = "github:cachix/devenv";
  };
  outputs = {
    nixpkgs,
    home-manager,
    devenv,
    ...
  } @ inputs: let
    inherit (self) outputs;
    # supported systems
    systems = [
      "x86_64-linux"
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
      bigfin = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./nixos/configuration.nix
        ];
      };
    };
    # homemanager entrypoint
    homeConfigurations = {
      "lxbtlr@bigfin" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit inputs outputs;};
        modules = [
          ./home-manager/home.nix
        ];
      };
    };
  };
}
