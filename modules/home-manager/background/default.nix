{pkgs, lib,...}:

let
  background-package = pkgs.stdenvNoCC.mkDerivation {
    name = "background-image";
    src = ./.;
    dontUnpack = true;
    installPhase = ''
      cp $src/IMG_1304.JPG $out
    '';
  };
in
{
  #services.xserver.enable = true;
  services.displayManager.sddm = {
    enable = lib.mkDefault true;
    wayland.enable = true;
  };
  environment.systemPackages = [
    (
      pkgs.writeTextDir "share/sddm/themes/breeze/theme.conf.user" ''
        [General]
        background = ${background-package}
      ''
    )
  ];
}
