{
  config,
  pkgs,
  lib,
  ...
}: {
  imports = [
    # import overlay
    ./../../../overlays/waybar.nix
  ];

  #environment.systemPackages = with pkgs; [
  #  waybar
  #];
  programs.waybar = {
    enable = true;
    systemd = {
      enable = false;
      target = "graphical-session.target";
    };
    style = import ./wb_style.nix;

    settings = import ./wb_settings.nix;
  };
}
