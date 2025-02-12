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
    # notification system
    ./../../modules/home-manager/mako
    # add sioyek config once created
    ./../../modules/home-manager/sioyek
    #./../../modules/home-manager/waybar
    ./../../modules/home-manager/rofi
    # change this
    ./../../modules/home-manager/stock_packages.nix
    #./../../modules/home-manager/texlive.nix
    # inputs.nix-colors.homeManagerModules.default

    # import proton mail wrapper -- not working
    #../../modules/home-manager/protonmail.nix
    # import xremap
    inputs.xremap-flake.homeManagerModules.default
  ];
  #TODO: move this to its own module
  services.xremap = {
    enable = true;
    config = {
      modmap = [
        {
          name = "main remaps";
          remap = {
            "CapsLock" = "ctrl_R";
            #"CapsLock" = "ctrl";
          };
        }
      ];
    };
  };
  nixpkgs = {
    # add overlays here
    overlays = [
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages
    ];

    config = {
      allowUnfree = true;
      #allowUnfreePredicate = _: true;
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
    configExtra = {
      init.defaultBranch = "main";
    };
  };

  programs.home-manager = {
    enable = true;
  };

  home.stateVersion = "23.05";
}
