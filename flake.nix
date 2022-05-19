{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-21.11;
    flake-utils.url = github:numtide/flake-utils;
    cbonsai.url = path:./cbonsai;
  };
  outputs = { self, nixpkgs, flake-utils, cbonsai }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in rec {
        packages.cbonsai = cbonsai.defaultPackage.${system};
      });
}

