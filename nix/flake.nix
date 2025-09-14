{
  description = "raylibAPL is a library made to write cross-platform graphical applications using the Dyalog APL programming language";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    temp-c-raylib = { url="github:Brian-ED/temp-c-raylib"; inputs.nixpkgs.follows="nixpkgs"; };
  };
  outputs = { self, flake-utils, nixpkgs, temp-c-raylib }: let
    systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" ];
  in flake-utils.lib.eachSystem systems (system:
    let
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages.default = import ./default.nix {
        temp-c-raylib = temp-c-raylib.packages.${pkgs.system}.default;
        inherit (pkgs) lib stdenv;
      };
      devShells.default = import ./shell.nix {inherit pkgs;};
    }
  );
}
