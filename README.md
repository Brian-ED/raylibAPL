# raylibAPL
raylibAPL is a library made to write cross-platform graphical applications using the Dyalog APL programming language.

## Features
<img align="right" style="width:240px" src="https://github.com/user-attachments/assets/bf969426-7741-4eda-aa03-5c90ee6f87de">
Features not showcased in examples are crosssed out, since they are untested.

- Supports platforms Windows, Linux, and MacOS.
- Input-methods: Keyboard, Mouse, ~~Controler~~, and ~~Touchscreen~~.
- Graphics: 2D, 3D, Sound, Text, Vector graphics, Images/Textures, and shaders.
- Multiple Fonts formats supported (TTF, ~~OTF~~, ~~Image fonts~~, ~~AngelCode fonts~~).
- Multiple texture formats supported, ~~including compressed formats (DXT, ETC, ASTC).~~
- Full 3D support, including ~~3D Shapes~~, Models, ~~Billboards~~, ~~Heightmaps~~, and more!
- Flexible Materials system, supporting classic maps and ~~PBR maps~~.
- ~~Animated 3D models supported (skeletal bones animation) (IQM, M3D, glTF).~~
- Shaders support, ~~including model shaders and postprocessing shaders~~.
- ~~Powerful math module for Vector, Matrix, and Quaternion operations: raymath~~.
- Audio loading and playing with streaming support (WAV, ~~QOA~~, ~~OGG~~, MP3, ~~FLAC~~, ~~XM~~, ~~MOD~~).
- VR stereo rendering support with configurable HMD device parameters.

# Warning
This library interfaces with C code that is prone to crashing Dyalog. If you experience code 999, there was likely a "segfault"/error in raylibAPL or [raylib](<https://github.com/raysan5/raylib/>), and so a bug report would be appreciated.

# Documentation

## Installing
There are two ways to get started, with Tatin and without. Easiest is using Tatin, though it's not consistent in Dyalog v19.

### Install Without Tatin
Run the following to install [temp-c-raylib](https://github.com/Brian-ED/temp-c-raylib/) into the `raylibAPL/lib/` folder.
```bash
dyalogscript install-raylib.apls
```
Instead of running the above, you can manually download temp-c-raylib from it's [releases page](https://github.com/Brian-ED/temp-c-raylib/releases/) and move the binary into `raylibAPL/lib/`.

If you're familiar with Nix, you can instead use temp-c-raylib's `default.nix` and `flake.nix`.

### Install With Tatin
[Tatin](https://tatin.dev/) is a package manager for Dyalog APL.

Install Tatin via `]Activate tatin` if not already installed, then install raylibAPL:
```apl
]Tatin.InstallPackages raylibAPL
```

If you experience the error `Invalid user command;`, please install without Tatin.

## Importing
Importing with Tatin assumes you have installed raylibAPL with Tatin. Both of the other methods work with and without Tatin.

### Importing With ⎕Fix
To import raylibAPL via ⎕Fix, take the code below and replace `../` with the path to the folder/directory containing raylibAPL:
```apl
rlDir ← '../raylibAPL/link/',⍨⊃1⎕NPARTS''
rl ← 0⎕Fix rlDir,'raylib.apln'
rl.Init rlDir
```
When making a script file like the raylibAPL's examples, I would recommend the `.apls` file extension and adding this line at the top of the script `#!/usr/bin/dyalogscript`. Remember to run `.apls` files from the containing folder/directory.

### Importing With Tatin
```apl
⍝ Load the package
⎕SE.Tatin.LoadDependencies ('packages' '#')
rl ← raylibAPL.raylib

⍝ Initialize (Tatin handles the path automatically)
rl.Init raylibAPL.TatinVars.HOME,'/link'
```

### Import With \]Link:
You may [\]Link](https://dyalog.github.io/link/4.0/API/) to the `raylibAPL/link` folder, which imports `raylib.apln`, `rlgl.apln`, `raymath.apln`, [`physac.apln`](https://github.com/victorfisac/Physac), and [`raygui.apln`](https://github.com/raysan5/raygui):

```apl
]cd /home/brian/raylibAPL/link
]link.create # .
rl ← raylib
rl.Init ''
```

#### Try Running Something
> **⚠️ macOS Users**: Start Dyalog with the `ENABLE_CEF=0` environment variable set to avoid HtmlRenderer conflicts. This can be done in the command line, or if you're using [RIDE](https://github.com/Dyalog/ride), in the environment variables textbox on startup.
> ```bash
> ENABLE_CEF=0 dyalog
> ```

Try running the following after importing raylib as rl:
```
rl.InitWindow 800 800 'Hello World!'
:While ~rl.WindowShouldClose⍬
    rl.BeginDrawing⍬
        rl.ClearBackground rl.color.gray
    rl.EndDrawing⍬
:EndWhile
rl.CloseWindow⍬
```


## Programming with raylibAPL
raylibAPL is a direct, low-level interface to the raylib C library, providing approximately 200 functions that either return values or modify the application state.

### Core Concept: Scopes
Some raylib functions start and end scopes, like `rl.InitWindow`  `rl.CloseWindow`.
During different scopes, different functions can run. For example, `rl.GetWindowPosition⍬` can only be run after a window scope. There are many different scopes, `InitWindow`→`CloseWindow`, `BeginDrawing`→`EndDrawing`, `BeginMode3D`→`EndMode3D`, and so on. The naming convention for scopes is that they are either `Begin...`→`End...`, or `Init...`→`Close...`. All scope information can be found in [this JSON file](https://github.com/Brian-ED/raylibAPL/blob/master/parse-raylib-apl/auto-error/raylib.json), which is used to generate [replicas of raylib functions](https://github.com/Brian-ED/raylibAPL/blob/master/non-link/raylibReplacement.apln.hide) that error instead of crashing.

#### Example 1: The InitWindow scope
Here is a raylibAPL application, that creates a window and gets window position:
```apl
rl.InitWindow 800 600 'My Application'
    ⍝ Window scope is now active
    ⍝ Many raylib functions are now available, like:
    WinPos ← rl.GetWindowPosition⍬
rl.CloseWindow⍬
⍝ Window scope is now closed
```

#### Example 2: The BeginDrawing scope
Most rendering must occur within a drawing scope, which is nested inside the window scope:

```apl
rl.InitWindow 800 600 'My Application'
    rl.BeginDrawing⍬
        ⍝ Drawing scope is active
        ⍝ Can now use drawing functions
        rl.ClearBackground rl.color.black
        rl.DrawText 'Hello, World!' 10 10 20 rl.color.white
    rl.EndDrawing⍬ ⍝ Throttles to make FPS be the monitor refresh rate
    ⍝ Drawing scope is closed and frame is presented
rl.CloseWindow⍬
```
`EndDrawing` automatically handles frame timing, limiting your application to the monitor's refresh rate (typically 60 FPS). If your frame logic takes longer than 1/60th of a second, `EndDrawing` won't add additional delay. This delay can be set via `SetTargetFPS`.

### Minimal application
Here's a minimal raylibAPL example, saying "hello world" on a gray background:
```apl
rl.InitWindow 800 800 'abc' ⍝ Begin window scope

:While ~rl.WindowShouldClose⍬             ⍝ Run this loop per frame
    rl.BeginDrawing⍬                      ⍝ Start drawing scope
        rl.ClearBackground⍬ rl.color.gray ⍝ Set background to gray
        rl.DrawText 'hello world' 10 10 20 rl.color.white
    rl.EndDrawing⍬                        ⍝ End scope
:EndWhile

rl.CloseWindow⍬
```
### Application pattern
It is recommended that raylibAPL applications follow this pattern:
1. Initialize the library
2. Create a window
3. Load resources (textures, sounds, etc.)
4. Enter the main loop ([details](https://lazyfoo.net/articles/article04/index.php)):
   - Process input
   - Update game state
   - Draw the frame
5. Clean up resources
6. Close the window

### Exploring Further

- **Examples**: Check out the [examples directory](https://github.com/Brian-ED/raylibAPL/tree/master/examples) for practical demonstrations. They can be run via dyalogscript, for example run `duck3D.apls` via `dyalogscript raylibAPL/examples/duck3D.apls`.
- **API Reference**: Examine the [raylib.apln file](https://github.com/Brian-ED/raylibAPL/blob/master/link/raylib.apln) for available functions and constants. Please ignore the `RAYLIB` suffix on the functions, since you should call the error-checking [wrapped versions](https://github.com/Brian-ED/raylibAPL/blob/master/non-link/raylibReplacement.apln.hide).
- **Scope information**: See [this json file](https://github.com/Brian-ED/raylibAPL/blob/master/parse-raylib-apl/auto-error/raylib.json) for all information on scopes. It is used to generate [replicas of raylib functions](https://github.com/Brian-ED/raylibAPL/blob/master/non-link/raylibReplacement.apln.hide) that error instead of crashing.
- **raylib Documentation**: Sometimes, [raylib's documentation](https://github.com/raysan5/raylib/wiki) applies to raylibAPL aswell.

## Re-generating bindings
The bindings are automatically generated. If you need to regenerate them:

1. Install [CBQN](https://github.com/dzaima/CBQN)
2. Run: `bqn raylibAPL/parse-raylibAPL/parseAll.bqn`

This parsing system converts the raylib C headers into APL functions that interface with the compiled binary generated by [temp-c-raylib](https://github.com/Brian-ED/temp-c-raylib).

# Credits

### Dyalog Limited
raylibAPL has been financially supported by [Dyalog Limited](https://www.dyalog.com/).
Brian was hired as an intern by [Dyalog Limited](https://www.dyalog.com/) at about 7th of July 2024 to develop raylibAPL, alongside [Asher](https://github.com/asherbhs). Brian has continued being funded for the development.
[The Dyalog team](https://www.dyalog.com/meet-team-dyalog.htm) have helped a lot with the development of this library.

### raylib
raylibAPL relies on the [raylib C library](https://github.com/raysan5/raylib/). Lots of thanks to raysan5 and the raylib community for this great library.

### Marshall Lochbaum
The current version of raylibAPL has parsing that relies on [json.bqn made by Marshall Lochbaum](https://github.com/mlochbaum/bqn-libs/blob/master/json.bqn). Also the BQN programming language in general!
