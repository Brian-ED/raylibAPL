{
  raylibAPL,
  stdenv,
  versionNums,
  writeShellScriptBin,
  tatinCLI,
}: let
  tatinPkgName = "BrianED-raylibAPL-${versionNums}";
  tatinDirForLib = "./packages/${tatinPkgName}";
  raylibLibInTatinPkgDir = "${tatinDirForLib}/lib/libtemp-c-raylib.so";
  raylibAPLTatinInstall = writeShellScriptBin "raylibAPLTatinInstall" ''
    if [ ! -d "${tatinDirForLib}" ]; then
      echo "Installing raylibAPL via tatin"
      ${tatinCLI}/bin/tatin install ${tatinPkgName}
    fi
    if [ -e "${raylibLibInTatinPkgDir}" ]; then
      echo "The raylib library is already installed at ${raylibLibInTatinPkgDir}."
    elif [ ! -d ${tatinDirForLib} ]; then
      echo "Error: Tatin did not install successfully. Aborting."
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
