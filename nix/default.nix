{
  lib,
  stdenv,
  temp-c-raylib,
  versionNums
}: stdenv.mkDerivation (finalAttrs: {
  pname = "raylibAPL";
  version = "v${versionNums}";
  src = ./..;

  buildPhase = ''
    mkdir -p "$out/lib"
    ln -s "${temp-c-raylib}/lib/libraylib.so" "$out/lib/libtemp-c-raylib.so"
    cp -r ./link "$out"
    cp -r ./examples "$out"
    cp -r ./testing "$out"
    cp apl-package.json "$out/apl-package.json"
  '';

  meta = {
    description = "raylibAPL is a library made to write cross-platform graphical applications using the Dyalog APL programming language";
    homepage    = "https://github.com/Brian-ED/raylibAPL";
    license     = lib.licenses.mit;
    platforms   = lib.platforms.all;
  };
})
