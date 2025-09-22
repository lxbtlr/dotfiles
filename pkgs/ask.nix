let
  pkgs = import <nixpkgs> { };
in
pkgs.stdenv.mkDerivation rec {
  name = "ask";
  pname = "ask";
  #kbuilder = ''${pkgs.bash}/bin/bash'';
  src = pkgs.fetchgit {
    url = "https://github.com/lxbtlr/ask";
    rev = "1561e4041ddc0d07e75d981b6d4a045914a1557c";
    sha256 = "sha256-2qzoYXjMl/oYGRP036DlB7ZTsXi/BSW7cYbwZh7Lppo=";
  };


  # args = [./install.sh ];
  buildInputs = with pkgs; [
    bc
    bash
    curl
    jq
  ]; # look at subsitutions in actual script
      ##  
  
  system = builtins.currentSystem;
  configurePhase = ''
  '';
  
  doBuild=false;
  #buildPhase = ''
  #'';
  postFixupHook = '' 
    
  ''; #look for nix stdlib for fixup pattern match

  installPhase = ''
  mkdir -p $out/bin
  cp $src/ask $out/bin
  export PATH=$out/bin/ask:$PATH
  '';


}
