{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-21.11;
    flake-utils.url = github:numtide/flake-utils;
    cbonsai.url = path:../cbonsai;
  };
  outputs = { self, nixpkgs, flake-utils, cbonsai }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        cbonsai-pkg = cbonsai.defaultPackage.${system};
        script = ''
          #! ${pkgs.bash}/bin/bash

          ${cbonsai-pkg}/bin/cbonsai --live
        '';
        cbonsai-live = pkgs.writeShellApplication {
          name = "kk";
          text = script;
        };
      in rec {
        defaultPackage = cbonsai-live;
      });
}
