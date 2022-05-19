{
  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-21.11;
    flake-utils.url = github:numtide/flake-utils;
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        cbonsai = pkgs.stdenvNoCC.mkDerivation {
          name = "cbonsai";
          src = pkgs.fetchFromGitLab {
            owner = "jallbrit";
            repo = "cbonsai";
            rev = "b3ee97a0";
            sha256 = "8JwwrTS8pOLwNYsnBGwqazGrTbts7LADndEdTit6Kc0=";
          };
          nativeBuildInputs = with pkgs; [ gcc gnumake pkg-config ];
          buildInputs = with pkgs; [ ncurses makeWrapper ];
          installPhase = ''
            make install PREFIX=$out
          '';
          # preFixup = ''
          #   wrapProgram "$out/bin/cbonsai" --add-flags "--live"
          # '';
          preFixup = ''
            $out/bin/cbonsai
          '';
        };
      in rec {
        defaultPackage = cbonsai;
      });
}

