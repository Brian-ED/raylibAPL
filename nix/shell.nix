{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  buildInputs = with pkgs; [
    git
    bqn
  ];

  shellHook = ''
    # Initialize submodule if c-header-to-bqn-ffi doesn't exist
    if [ ! -f imports/c-header-to-bqn-ffi/parse.bqn ]; then
      echo "Submodule c-header-to-bqn-ffi doesn't exist. Auto-creating it."
      ${pkgs.git} submodule update --init --recursive
    fi
  '';
}
