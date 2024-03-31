{
  lib,
  config,
  pkgs,
  ...
}:
{

  imports = [
    # import other parts of home-manager config + other modules
    ./alacritty.nix
    ./bash.nix
    ./kitty.nix
    ./starship.nix
    # inputs.nix-colors.homeManagerModules.default
  ];


};
