{
  programs.ghostty = {
    enable = true;
    enableBashIntegration = true;
    #systemd.enable = true;
    installVimSyntax = true;
    settings = {
      #theme="TokyoNight Moon";
      theme = "Oxo-Fixed";
      scrollback-limit = "4000";
      font-family = "JetBrains Mono Regular";
      font-size = 11;
      window-padding-x = 5;
      window-padding-y = 5;
      copy-on-select = true;
      bold-is-bright = true;
      cursor-style = "block";
      cursor-style-blink = true;
      shell-integration-features = ["no-cursor" "ssh-env"];
      #keybind = "toggle-tab-overview=ctrl+,";
      #background-image="/home/lxbtlr/Downloads/2544.png";
      #background-image-opacity=0.01;
    };
    themes = {
      Oxo-Fixed = {
        background = "#161616";
        cursor-color = "#ffffff";
        foreground = "#ffffff";
        selection-foreground = "#000000";
        selection-background = "#393939";
        cursor-text = "#0b0e14";
        palette = [
          "0=#262626"
          "1=#ee5396"
          "10=#42be65"
          "11=#ffe97b"
          "12=#33b1ff"
          "13=#ff7eb6"
          "14=#3ddbd9"
          "15=#ffffff"
          "2=#42be65"
          "3=#ffe97b"
          "4=#33b1ff"
          "5=#ff7eb6"
          "6=#3ddbd9"
          "7=#dde1e6"
          "8=#393939"
          "9=#ee5396"
        ];
      };
    };
  };
}
