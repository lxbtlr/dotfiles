# Stylix, ported from the nixferatu config.
#
# The critical difference: that config runs niri as the only desktop, so it can
# theme GTK and Qt freely. You still boot Plasma, and stylix has no concept of
# "only in this session" — a GTK theme is just a file in your home directory.
#
# So this sets autoEnable = false and opts in target by target. Nothing is
# themed unless it is listed below.

{ pkgs, ... }:

{
  stylix = {
    enable = true;

    # OPT-IN ONLY. With this false, every stylix target defaults to disabled.
    # This is what keeps Plasma looking like Plasma.
    autoEnable = false;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/black-metal.yaml";
    # Alternatives from the original config:
    #   black-metal-gorgoroth.yaml
    #   vesper.yaml
    #   rose-pine.yaml
    #   terracotta.yaml

    # Point this at the same file swaybg uses in your niri config, or the
    # wallpaper and the palette will disagree.
    image = ./bg.jpg;
    polarity = "dark";

    cursor = {
      package = pkgs.volantes-cursors;
      name = "volantes_cursors";
      size = 24;
    };

    fonts = {
      serif = {
        package = pkgs.poppins;
        name = "Poppins";
      };
      sansSerif = {
        package = pkgs.poppins;
        name = "Poppins";
      };
      monospace = {
        package = pkgs.maple-mono.truetype;
        name = "Maple Mono";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };

    targets = {
      # niri itself — provided by niri-flake's stylix module
      niri.enable = true;

      waybar.enable = true;
      ghostty.enable = true; # was kitty.enable in the original
      btop.enable = true;
      tmux.enable = true;

      fish.enable = false;
      neovim.enable = false;

      # Explicitly off. Redundant under autoEnable = false, but these are the
      # three that would visibly repaint your Plasma session, so they are
      # spelled out rather than left implicit.
      gtk.enable = false;
      qt.enable = false;
      kde.enable = false;
    };
  };
}
