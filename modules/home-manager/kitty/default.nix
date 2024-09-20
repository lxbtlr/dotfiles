{
config,
lib,
pkgs,
...
}: {
  programs.kitty = {
    enable = true;
    theme = "Tokyo Night";
    settings = {
      window_border_width = -0;
      draw_minimal_borders = "no";
      hide_window_decorations = "yes";
      copy_on_select = true;
      shell_integration = "no-rc"; # I prefer to do it manually
      scrollback_lines = 4000;
      scrollback_pager_history_size = 2048;
      window_padding_width = 5;
    };
  };
}
