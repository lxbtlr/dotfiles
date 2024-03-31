{}: {
  programs.kitty = {
    enable = true;
    settings = {
      window_border_width = 0;
      draw_minimal_borders = "yes";
      hide_window_decorations = "yes";
      shell_integration = "no-rc"; # I prefer to do it manually
      scrollback_lines = 4000;
      scrollback_pager_history_size = 2048;
      window_padding_width = 15;
    };
  };
}
