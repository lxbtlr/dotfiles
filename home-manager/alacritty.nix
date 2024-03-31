{
  config,
  lib,
  pkgs,
  ...
}: {
  # alacritty program settings / config
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env = {
        "TERM" = "xterm-256color";
      };

      window.opacity = 0.95;

      window = {
        padding.x = 10;
        padding.y = 10;
        decorations = "None";
      };

      font = {
        size = 12.0;
        AppleFontSmoothing = true;

        normal.family = "JetBrainsMono";
        bold.family = "JetBrainsMono";
        italic.family = "JetBrainsMono";
      };

      cursor.style = "Beam";

      shell = {
        program = "bash";
        # args = [
        #   "neofetch"
        # ];
      };

      colors = {
        # Default colors
        primary = {
          background = "#161616";
          foreground = "#ffffff";
        };

        # Normal colors
        normal = {
          black = "#262626";
          magenta = "#ff7eb6";
          green = "#42be65";
          yellow = "#ffe97b";
          blue = "#33b1ff";
          red = "#ee5396";
          cyan = "#3ddbd9";
          white = "#dde1e6";
        };

        # Bright colors
        bright = {
          black = "#393939";
          magenta = "#ff7eb6";
          green = "#42be65";
          yellow = "#ffe97b";
          blue = "#33b1ff";
          red = "#ee5396";
          cyan = "#3ddbd9";
          white = "#ffffff";
        };
      };
    };
  };
}
