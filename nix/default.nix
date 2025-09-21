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
    mkdir -p $out/lib
    cp ${temp-c-raylib}/lib/libtemp-c-raylib.so $out/lib
    cp -r ./link $out
    cp -r ./non-link $out
    cp -r ./examples $out
    cp -r ./testing $out
  '';

  meta = {
    description = "raylibAPL is a library made to write cross-platform graphical applications using the Dyalog APL programming language";
    homepage    = "https://github.com/Brian-ED/raylibAPL";
    license     = lib.licenses.mit;
    platforms   = lib.platforms.all;
  };
})
