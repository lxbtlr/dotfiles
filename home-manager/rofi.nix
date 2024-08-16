{pkgs, ...}: let
  fontSize = 24;
in {
  programs.rofi = {
    enable = true;

    extraConfig = {
      bw = 1;
      columns = 2;
      icon-theme = "Papirus-Dark";
      modi = "run,calc,window";
    };

    theme = "Monokai";

    font = "Fira Code ${toString fontSize}";

    plugins = with pkgs; [rofi-calc rofi-emoji rofi-systemd];

    terminal = "${pkgs.kitty}/bin/kitty";
  };

  # for rofi-emoji to insert emojis directly
  home.packages = [pkgs.xdotool];
}
