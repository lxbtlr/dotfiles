{
  inputs,
  outputs,
  config,
  lib,
  pkgs,
  nixpkgs,
  ...
}: {
  home.packages = with pkgs; [
    marksman

    # qt
    libsForQt5.qt5.qtsvg         #: support for SVG image loading (bundled with most packages)
    libsForQt5.qt5.qtimageformats# : support for WEBP images as well as some less common ones
    libsForQt5.qt5.qtmultimedia  # : support for playing videos, audio, etc
    kdePackages.qt5compat     # : extra visual effects, notably gaussian blur. MultiEffect is usually preferable

    #photo editor (FOSS lightroom)
    darktable
    
    gemini-cli

    #music
    tidal-hifi

    firewalld
    libvirt
    # notes & reading
    obsidian
    tmuxinator
    zathura
    zettlr
    zotero
    kitty
    pandoc
    newsflash

    poppler_utils

    protonvpn-gui

    # av
    drawio
    sonic-pi
    orca-c
    qimgv
    ffmpeg_6
    ardour

    zoom


    # data
    visidata
    gnused
    gnutar
    gawk
    zstd

    # meetings / comms
    telegram-desktop

    # langs
    devenv
    processing
    #gcc9 # C compiler

    nodejs

    opam
    ocaml

    # digital logic
    logisim
    f3d

    # managing nix documentation
    manix
    cachix
    alejandra # nix code formatter
    nix-output-monitor

    #wayland
    wl-clipboard
    wl-color-picker
    waybar
    #rofi.override {plugins = [rofi-calc rofi-emoji rofi-systemd];};
    #rofi-wayland

    # archives
    zip
    xz
    unzip
    p7zip

    # networking tools
    mtr # A network diagnostic tool
    iperf3
    dnsutils # `dig` + `nslookup`
    ldns # replacement of `dig`, it provide the command `drill`
    aria2 # A lightweight multi-protocol & multi-source command-line download utility
    socat # replacement of openbsd-netcat
    nmap # A utility for network discovery and security auditing
    ipcalc # it is a calculator for the IPv4/v6 addresses

    # misc & utils
    ocs-url
    #libsForQt5.krdc
    cowsay
    gsettings-desktop-schemas
    neofetch
    spotify
    nnn # terminal file manager
    fuzzel
    flameshot
    ripgrep # recursively searches directories for a regex pattern
    jq # A lightweight and flexible command-line JSON processor
    yq-go # yaml processer https://github.com/mikefarah/yq
    eza # A modern replacement for ‘ls’
    fzf # A command-line fuzzy finder
    zoxide
    file
    which
    tree
    gnupg

    # diagnostic
    htop-vim
    btop # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring

    # productivity
    hugo # static site generator
    glow # markdown previewer in terminal

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
    polkit_gnome
    libva-utils
    fuseiso
    udiskie
    adwaita-icon-theme
    gnome-themes-extra
    nvidia-vaapi-driver
    gsettings-desktop-schemas
    swaynotificationcenter
    wlr-randr
    ydotool
    #hyprland-share-picker
    #hyprland-protocols
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
}
