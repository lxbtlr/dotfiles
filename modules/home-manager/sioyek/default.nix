{pkgs, ...}: {
  # slowly building config

  #home.packages = with pkgs; [
  programs.sioyek = {
    enable = true;
    bindings = {
      "screen_down" = ["d" "<C-d>"];
      "screen_up" = ["u" "<C-u>"];
      "enter_visual_mark_mode" = ["<C-v>"];
    };
    config = {
      "middle_click_search_engine" = "https://www.kagi.com/search?q=";
      "font_size" = "12";
    };
  };
  #];
}
