{pkgs ? import <nixpkgs> {}}:
pkgs.mkShell {
  packages = [
    (pkgs.python311.withPackages (ps: [
      ps.numpy
      ps.pandas
      ps.plotly
      ps.pygame
      ps.matplotlib
    ]))
  ];
}
