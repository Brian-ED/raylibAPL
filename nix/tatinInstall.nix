{
  raylibAPL,
  stdenv,
  versionNums,
  writeShellScriptBin,
  tatinCLI,
}: let
  tatinDirForLib = "./packages/BrianED-raylibAPL-${versionNums}";
  raylibLibInTatinPkgDir = "${tatinDirForLib}/lib/libraylib.so";
  raylibAPLTatinInstall = writeShellScriptBin "raylibAPLTatinInstall" ''
    if [ ! -d "${tatinDirForLib}" ]; then
      echo "Installing raylibAPL via tatin"
      ${tatinCLI}/bin/tatin install raylibAPL
    fi
    if [ -e "${raylibLibInTatinPkgDir}" ]; then
      echo "The raylib library is already installed at ${raylibLibInTatinPkgDir}"
    else
      mkdir -p "${tatinDirForLib}/lib"
      ln -s "${raylibAPL}/lib/libtemp-c-raylib.so" "${raylibLibInTatinPkgDir}"
      echo "Successfully linked temp-c-raylib library into \"${tatinDirForLib}/lib\""
    fi
  '';
in stdenv.mkDerivation (finalAttrs: {
  pname = "raylibAPLTatinInstall";
  version = "v${versionNums}";
  src = ./..;

  buildInputs = [ raylibAPL ];

  buildPhase = ''
    mkdir -p $out/bin
    cp ${raylibAPLTatinInstall}/bin/raylibAPLTatinInstall $out/bin/raylibAPLTatinInstall
  '';
})
