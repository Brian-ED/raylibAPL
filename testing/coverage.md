# Tested on raylibAPL commit 2e32bf0. The commit before release v1.0.0
Below are test cases.
During a given test, the following needs to be specified:
  raylibAPL commit or version.
  Whether it's a non-reproducable or reproducable environment. Examples of reproducable would be inside docker or nix.
  OS, and it's version.
  Dyalog version.

  Optional:
    Hardware information. For example Lenovo-Yoga-C940-14IIL.
    When specifying a reproducable environment, a link to the reproducable code with a open source licence.

## Windows 10 testcase

Environment:
  Github submodules are installed.
  `temp-c-raylib` is installed with `dyalogscript install-raylib.apls`
  `dyalogscript` is on path.
  current directory: `./testing`.

Actions:
  1. In PowerShell, run `run-all-examples.ps1`.
  2. A window opens, do nothing and close it with the Escape key after 2 seconds.
  3. Repeat step 2 till no window opens and command ends.

Output:
  stdout: `WARNING: VAO: [ID 2] Trying to re-load an already loaded mesh`
  One example plays music.

Known issues:
  `shader.apls` is removed from `run-all-exampls.ps1` due to it hanging.

### Windows 10 test
Environment:
  raylibAPL commit 2e32bf0.
  Done on Brian's Lenovo-Yoga-C940-14IIL, in a non-reproducable environment.
  Github submodules are installed.
  Windows 10 version: ???
  Dyalog version: ???
  `temp-c-raylib` is installed with `dyalogscript install-raylib.apls`
  `dyalogscript` is on path.
  current directory: `./testing`.

Actions:
  1. In PowerShell, run `run-all-examples.ps1`.
  2. A window opens, do nothing and close it with the Escape key after 2 seconds.
  3. Repeat step 2 till no window opens and command ends.

Output:
  stdout: `WARNING: VAO: [ID 2] Trying to re-load an already loaded mesh`
  One example plays music.

Known issues:
  `shader.apls` is removed from `run-all-exampls.ps1` due to it hanging.




## Linux NixOS
Environment:
  Done on Brian's Lenovo-Yoga-C940-14IIL, in a [reproducable environment](https://github.com/Brian-ED/brian-nixos-config/tree/main).
  Run `nix build` inside temp-c-raylib v6.0.0 and sym-link the relative path `../../temp-c-raylib/result/lib/libtemp-c-raylib.so` as `raylibAPL/lib/libtemp-c-raylib.so`.
  Dyalog version: 19.0.50027.
  `dyalogscript` is on path.
  Current directory: `./testing`.

Actions:
  1. Using sh, run `run-all-examples.sh`.
  2. A window opens, do nothing and close it with the Escape key after 2 seconds.
  3. Repeat step 2 till no window opens and command ends.

Output:
  Standard Out: `WARNING: VAO: [ID 2] Trying to re-load an already loaded mesh\n`

Known issues:
  `music-test.apls` does not play music.
