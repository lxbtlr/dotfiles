{pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/eabc38219184cc3e04a974fe31857d8e0eac098d.tar.gz") {} }:
pkgs.mkShell {
  packages = [
    (pkgs.python311.withPackages (ps: [

      ps.numpy
      ps.pandas
      ps.requests
      ps.plotly
      ps.pygame
      ps.matplotlib
      ps.seaborn
    ]))

  ];

}
