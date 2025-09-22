{pkgs, ...}: {
  # TODO: move fonts to their own file
  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = false;
    packages = with pkgs; [
      material-icons
      material-design-icons
      victor-mono
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      liberation_ttf
      nerd-fonts.victor-mono 
      nerd-fonts.roboto-mono
      nerd-fonts.jetbrains-mono
      nerd-fonts.hack
      #(nerdfonts.override {fonts = ["VictorMono" "RobotoMono" "JetBrainsMono" "Hack"];})
      lexend
      roboto
      roboto-mono
      jetbrains-mono
      hack-font
      manrope
    ];
    fontconfig.defaultFonts = {
      serif = ["DejaVu Serif" "Noto Color Emoji"];
      sansSerif = ["DejaVu Sans" "Noto Color Emoji"];
      monospace = ["JetBrains Mono Medium Nerd Font Complete"];
      emoji = ["Noto Color Emoji"];
    };
  };
}
