{pkgs ? import <nixpkgs> {}}:
with pkgs; let
in
  mkShell {
    buildInputs = [
      nodejs_20
      yarn
    ];
  }
