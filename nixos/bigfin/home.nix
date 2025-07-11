{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    # import other parts of home-manager config + other modules
    ./../../modules/home-manager/direnv
    ./../../modules/home-manager/bash
    ./../../modules/home-manager/kitty
    ./../../modules/home-manager/starship
    ./../../modules/home-manager/nvim
    ./../../modules/home-manager/tmux
    ./../../modules/home-manager/waybar
    ./../../modules/home-manager/rofi

    # notification system
    ./../../modules/home-manager/mako
    # add sioyek config once created
    ./../../modules/home-manager/sioyek

    # change this
    ./../../modules/home-manager/stock_packages.nix
    # inputs.nix-colors.homeManagerModules.default
  ];

  nixpkgs = {
    # add overlays here
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];

    config = {
      allowUnfree = true;
      allowUnfreePredicate = _: true;
    };
  };

  home = {
    username = "lxbtlr";
    homeDirectory = "/home/lxbtlr";
  };
  # TODO: make this a machine specific thing (for bigfin)
  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 36;
    "Xft.dpi" = 172;
  };

  programs.git = {
    enable = true;
    userName = "Alex Butler";
    userEmail = "lxbtlr@pm.me";
  };

  programs.home-manager = {
    enable = true;
  };

  home.stateVersion = "23.05";
}
