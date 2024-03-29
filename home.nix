{
  config,
  lib,
  pkgs,
  ...
}: {
  home.username = "lxbtlr";
  home.homeDirectory = "/home/lxbtlr";

  imports = [
    ./bash.nix
    ./starship.nix
    ./editor.nix
    ./hydra-nvim.nix
    ./alacritty.nix
    ./direnv.nix
    ./tmux.nix
    ./waybar.nix
    #./gsettings.nix
    #./fuzzel.nix
  ];

  # set cursor size and dpi for 4k monitor
  xresources.properties = {
    "Xcursor.size" = 16;
    "Xft.dpi" = 172;
  };

  # basic configuration of git, please change to your own
  programs.git = {
    enable = true;
    userName = "Alex Butler";
    userEmail = "lxbtlr@pm.me";
  };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    # email
    htop-vim
    obsidian
    drawio
    zoom-us
    webex
    cachix
    visidata
    fuzzel
    flameshot
    waybar
    orca-c
    sonic-pi
    ardour
    # pdf viewer
    zathura

    # notes & bibliographies
    zettlr

    # research & notes
    zotero

    # digital logic
    logisim
    f3d

    # nix code formatter
    alejandra

    qimgv
    wl-color-picker

    discordo
    discord
    telegram-desktop
    pandoc
    ocs-url
    # remote gui desktop tools
    rustdesk
    libsForQt5.krdc

    rofi-wayland
    ffmpeg_6

    nodejs
    neofetch
    spotify
    nnn # terminal file manager

    gsettings-desktop-schemas

    newsflash
    processing
    # archives
    zip
    xz
    unzip
    p7zip

    # utils
    wl-clipboard
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processer https://github.com/mikefarah/yq
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder

    # networking tools
    mtr # A network diagnostic tool
    iperf3
    dnsutils # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc # it is a calculator for the IPv4/v6 addresses
    tmuxinator
    # misc
    zoxide
    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    # nix related
    #
    # it provides the command `nom` works just like `nix`
    # with more details log output
    nix-output-monitor

    # productivity
    hugo # static site generator
    glow # markdown previewer in terminal

    btop # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # system call monitoring
    strace # system call monitoring
    ltrace # library call monitoring
    lsof # list open files

    # system tools
    sysstat
    lm_sensors # for `sensors` command
    ethtool
    pciutils # lspci
    usbutils # lsusb

    # hyprland flakes
    kitty
    polkit_gnome
    libva-utils
    fuseiso
    udiskie
    gnome.adwaita-icon-theme
    gnome.gnome-themes-extra
    nvidia-vaapi-driver
    gsettings-desktop-schemas
    swaynotificationcenter
    wlr-randr
    ydotool
    hyprland-share-picker
    hyprland-protocols
    hyprpicker
    swayidle
    swaylock
    xdg-desktop-portal-hyprland
    hyprpaper
    wofi
    swww
    grim
    xdg-utils
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    qt5.qtwayland
    qt6.qmake
    qt6.qtwayland
    adwaita-qt
    adwaita-qt6

    # hyprland packages 2
    swaybg
    wlogout
    wf-recorder
    slurp
    mako

    alsa-utils
    mpd
    mpc-cli
    ncmpcpp
    networkmanagerapplet
  ];

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = import ./hypr_config.nix {};
  };

  home.file.".config/hypr/colors".text = ''
    $background = rgba(1d192bee)
    $foreground = rgba(c3dde7ee)

    $color0 = rgba(1d192bee)
    $color1 = rgba(465EA7ee)
    $color2 = rgba(5A89B6ee)
    $color3 = rgba(6296CAee)
    $color4 = rgba(73B3D4ee)
    $color5 = rgba(7BC7DDee)
    $color6 = rgba(9CB4E3ee)
    $color7 = rgba(c3dde7ee)
    $color8 = rgba(889aa1ee)
    $color9 = rgba(465EA7ee)
    $color10 = rgba(5A89B6ee)
    $color11 = rgba(6296CAee)
    $color12 = rgba(73B3D4ee)
    $color13 = rgba(7BC7DDee)
    $color14 = rgba(9CB4E3ee)
    $color15 = rgba(c3dde7ee)
  '';

  home.stateVersion = "23.05";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
