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
    #hyprland-share-picker
    #hyprland-protocols
    hyprpicker
    swayidle
    swaylock
    xdg-desktop-portal-hyprland
    hyprpaper
    wofi
    grim
    xdg-utils
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    qt5.qtwayland
    qt6.qmake
    qt6.qtwayland
    adwaita-qt
    adwaita-qt6

    # hyprland packages 2
    swaybg
    wlogout
    wf-recorder
    slurp
    mako

    hyprland
    xwayland
    #waybar
    swww
  ];
  nix.settings = {
    substituters = lib.mkBefore ["https://hyprland.cachix.org"];
    trusted-public-keys = lib.mkBefore ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
  };
}
