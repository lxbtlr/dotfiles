{
  pkgs,
  lib,
  ...
}: {
  imports = [
    # import waybar
    #./../waybar/default.nix
  ];
  # have not tested hyprland extensively, if working, assume this only builds
  programs.hyprland = {
    enable = true;
    # nvidiaPatches = true;
    xwayland.enable = true;
  };
  environment.systemPackages = with pkgs; [
    hyprland
    xdg-desktop-portal-hyprland
    xwayland
    #waybar
    swww
  ];
  nix.settings = {
    substituters = lib.mkBefore ["https://hyprland.cachix.org"];
    trusted-public-keys = lib.mkBefore ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };
}
