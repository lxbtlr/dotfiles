# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  inputs,
  outputs,
  config,
  pkgs,
  ...
}:{
  nix.nixPath = [
    "nixpkgs=${pkgs.path}"
  ];
  imports = [
    # Include the results of the hardware scan.
    #<nixos-hardware/framework/13-inch/7040-amd>
    ./hardware-configuration.nix
    # import fonts
    ./../../modules/nixos/fonts.nix
    # import kde plasma5 settings
    ./../../modules/nixos/plasma6.nix
    # background
    ./../../modules/home-manager/background
    # import hm flake
    #./../../modules/home-manager/hyprland/default.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  hardware.uinput.enable = true;
  users.groups.uinput.members = ["lxbtlr"];
  users.groups.input.members = ["lxbtlr"];

  #programs.nix-ld.enable = true;
  services.envfs.enable = true;
  #TODO: finger print reader -- testing
  services.fprintd.enable = false;
  services.fwupd.enable = true; 
  services.power-profiles-daemon.enable = false;
  #services.printing.drivers = [
  #  pkgs.gutenprint
  #  (writeTextDir "share/cups/model/Ricoh-IM_C4510-Postscript-Ricoh.ppd" (builtins.readFile ./Ricoh-IM_C4510-Postscript-Ricoh.ppd))
  #];
  #programs.ssh = {forwardX11 = true;};
  programs.nix-ld.libraries = with pkgs; [
      stdenv.cc.cc
      zlib
      fuse3
  ];

  users.groups.libvirtd.members = ["lxbtlr" "root"];

  virtualisation.libvirtd.enable = true;
  
  virtualisation.spiceUSBRedirection.enable = true;

  #home.packages = with pkgs; [
  #programs.virt-manager = {
  #  enable = true;
  #};


  programs.virt-manager.enable = true;


  nix.settings.experimental-features = ["nix-command" "flakes"];
  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  home-manager = {
    #useGlobalPkgs = true;
    #useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = {inherit inputs outputs;};
    users = {
      # this is where we can add more hm-users / separate configs for user spaces
      lxbtlr = import ./home.nix;
    };
  };
  nixpkgs.config.allowUnfree = true;
  environment = {
    plasma6.excludePackages = [pkgs.kdePackages.baloo];
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      WLR_NO_HARDWARE_CURSORS = "1";
    };

    systemPackages = with pkgs; [
      # Add zen-browser from flake
      inputs.zen-browser.packages."${system}".default
      inputs.kwin-effects-forceblur.packages.${pkgs.system}.default # Wayland
      inputs.quickshell.packages."${system}".default
      slack
      #slack.override { nss = pkgs.nss_3_44; }
      vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
      claude-code
      devenv
      wget
      curl
      git
      dunst
      xdg-desktop-portal-gtk
      libnotify
      gtk3
      texliveFull
      qemu
      #(import ./../../pkgs/ask.nix) #todo: fix
    ];

    variables.EDITOR = "nvim";
  };

  nix.settings = {
    auto-optimise-store = true; # let the gc run automagically
    trusted-users = ["root" "lxbtlr"];
    substituters = ["https://devenv.cachix.org" "https://aseipp-nix-cache.global.ssl.fastly.net"];
    trusted-public-keys = ["devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="];
  };

  networking.hostName = "cuttlefish"; # Define your hostname.
  #:networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.powersave = false;

  #networking.networkmanager.wifi.backend = "iwd";

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
  # Enable CUPS to print documents.
  #services.printing.enable = true;

  # Enable sound with pipewire.
  #sound.enable = true;
  hardware = {
    bluetooth.enable = true;
  };
  security.rtkit.enable = true;
  security.protectKernelImage = false;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  users.users.lxbtlr = {
    isNormalUser = true;
    description = "alex butler";
    extraGroups = ["networkmanager" "wheel"];
    packages = with pkgs; [
      firefox
    ];
  };

  # XDG portal
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
