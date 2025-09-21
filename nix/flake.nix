{
  description = "raylibAPL is a library made to write cross-platform graphical applications using the Dyalog APL programming language";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    temp-c-raylib = { url="github:Brian-ED/temp-c-raylib"            ; inputs.nixpkgs.follows="nixpkgs"; };
    tatinCLIPkg   = { url="github:Bombardier-C-Kram/TatinCLI?dir=nix"; inputs.nixpkgs.follows="nixpkgs"; };
  };
  outputs = { self, flake-utils, nixpkgs, temp-c-raylib, tatinCLIPkg }: let
    systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" ];
  in flake-utils.lib.eachSystem systems (system:
    let
      tatinCLI = tatinCLIPkg.packages.${pkgs.system}.default;
      versionNums = "0.2.0";
      pkgs = nixpkgs.legacyPackages.${system};
      raylibAPL = import ./default.nix {
        temp-c-raylib = temp-c-raylib.packages.${pkgs.system}.default;
        inherit (pkgs) lib stdenv;
        inherit versionNums;
      };
      tatinInstall = import ./tatinInstall.nix {
        inherit raylibAPL versionNums tatinCLI;
        inherit (pkgs) stdenv writeShellScriptBin;
      };
    in {
      packages = {
        inherit raylibAPL tatinInstall;
        default = raylibAPL;
      };
      devShells.default = import ./shell.nix {
        inherit pkgs raylibAPL tatinInstall tatinCLI;
      };
    }
  );
}
