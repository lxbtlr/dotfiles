{
  pkgs,
  lib,
  config,
  inputs,
  root,
  ...
}: {
programs.ghostty = {
  enable= true;
  #enableBashIntegration = true;
  installVimSyntax = true;
  settings = {theme="TokyoNight Moon";
              scrollback-limit="4000";
              font-family="JetBrains Mono Regular";
              font-size=11;
              window-padding-x=5;
              window-padding-y=5;
              copy-on-select=true;
              bold-is-bright=true;
              cursor-style="block";
              cursor-style-blink=true;
              
              #background-image="/home/lxbtlr/Downloads/2544.png";
              #background-image-opacity=0.01;
              };
  themes = {
    ayo = {
      background = "#0b0e14";
      foreground = "#bfbdb6";
      selection-background = "#1b3a5b";
      selection-foreground = "#bfbdb6";
      cursor-color = "#bfbdb6";
      cursor-text = "#0b0e14";
      palette = [
      "0=#1e232b"
      "1=#ea6c73"
      "2=#7fd962"
      "3=#f9af4f"
      "4=#53bdfa"
      "5=#cda1fa"
      "6=#90e1c6"
      "7=#c7c7c7"
      "8=#686868"
      "9=#f07178"
      "10=#aad94c"
      "11=#ffb454"
      "12=#59c2ff"
      "13=#d2a6ff"
      "14=#95e6cb"
      "15=#ffffff"
      ];
      };
      };

};


}
