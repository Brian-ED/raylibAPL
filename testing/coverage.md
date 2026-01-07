Below are all **testcase**s, followed by all **test**s.

## Test cases

A **testcase** needs to specify, if avaliable:
- The environment, meaning what's expected to be true for the actions to work as intended.
- The actions, meaning what should be done to get the expected output.
- The intended output.
- Known issues.

### Windows 10 testcase
Environment:
  `temp-c-raylib` is installed with `dyalogscript install-raylib.apls`
  `dyalogscript` is on path.
  current directory: `./testing`.

Actions:
  1. In PowerShell, run `dyalogscript run-all-examples.apls`.
  2. A window opens, close it with the Escape key.
  3. If a new window opens, repeat step 2.

Intended output:
  stdout:
    WARNING: VAO: [ID 2] Trying to re-load an already loaded mesh
    WARNING: VAO: [ID 2] Trying to re-load an already loaded mesh

  One example plays music.

### Linux NixOS testcase
Environment:
  Current directory: `.`.

Actions:
  1. Run `nix build ./nix && cd ./result/testing && dyalogscript run-all-examples.apls`.
  2. A window opens, close it with the Escape key.
  3. If a new window opens, repeat step 2.

Intended output:
  stdout:
    WARNING: VAO: [ID 2] Trying to re-load an already loaded mesh
    WARNING: VAO: [ID 2] Trying to re-load an already loaded mesh`

  One example plays music.

### Linux NixOS testcase after dyalog 20 update
Same behavior as version 19.0 above.

### Linux Mint testcase
Environment:
  `temp-c-raylib` is installed with `dyalogscript install-raylib.apls`.
  `dyalogscript` is on path.
  current directory: `./testing`.

Actions:
  1. Run `dyalogscript run-all-examples.apls`.
  2. A window opens, close it with the Escape key.
  3. If a new window opens, repeat step 2.

Intended output:
  stdout:
    WARNING: VAO: [ID 2] Trying to re-load an already loaded mesh
    WARNING: VAO: [ID 2] Trying to re-load an already loaded mesh`

  One example plays music.

## Tests
The following list of tests each describe an environment where the testcases have been done on, aswell as the result.

A **test** needs to specify, if available:
- raylibAPL commit or version.
- Whether you're running in a reproducible environment or not. Examples of reproducible would be inside docker or nix.
- OS, and it's version.
- Dyalog APL interpreter version.
- The result, or "success" if the result is exactly as specified in the testcase.

A **test** can optionally also specifiy:
- Hardware information. For example Lenovo-Yoga-C940-14IIL.
- When specifying a reproducible environment, a link to the reproducible code with a open source licence.

### Windows 10 test
Environment:
- [raylibAPL commit](https://github.com/Brian-ED/raylibAPL/commit/ed61bb167dc9a6beb2bf8004823a928360f8e84e) "Releasing version 1.0.0".
- Done on Brian's Lenovo-Yoga-C940-14IIL, in Windows 10 Version 10.0.19045 Build 19045, in a non-reproducible environment.
- Dyalog 19.0.50074 64-bit Unicode, BuildID 09ca43b9.

Successful

### Linux NixOS test
Environment:
- [raylibAPL commit](https://github.com/Brian-ED/raylibAPL/commit/d4d38499ae0fba619476a38bf9c827d63b67b06f) "Updated nix flakes to use temp-c-raylib v8.0.0".
- Done on Brian's Lenovo-Yoga-C940-14IIL, in NixOS 25.11.20251002.7df7ff7, in a [reproducible environment](https://github.com/Brian-ED/brian-nixos-config/commit/029752e4cf14ca19aad4cfb6c551663eded07270).

Successful

### Linux Mint test
Environment:
- [raylibAPL commit](https://github.com/Brian-ED/raylibAPL/commit/ed61bb167dc9a6beb2bf8004823a928360f8e84e) "Releasing version 1.0.0".
- Dyalog version `Dyalog 19.0.50027 64-bit Unicode, BuildID 58fad6b9`.
- Done on Brian's Lenovo-Yoga-C940-14IIL, in Linux Mint 21.2 x86_64, in a non-reproducible environment.

Successful
