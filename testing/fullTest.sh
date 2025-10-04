#!/usr/bin/env sh
mkdir raylibAPL temp-c-raylib
mkdir raylibAPL/lib
cp -r ../link raylibAPL
cp -r ../examples raylibAPL
cp -r ../non-link raylibAPL
cp -r ../imports raylibAPL
# When direct cloning, remember to init submodules
git clone --filter=blob:none --recurse-submodules https://github.com/Brian-ED/temp-c-raylib.git?ref=803beb91841cc8e9b7e27b098ea02cae45ef430
git submodule update --init --recursive ..
cp result/lib/libtemp-c-raylib.so raylibAPL/lib/
cd raylibAPL/examples
dyalogscript "duck3D.apls"
dyalogscript "basicStart.apls"
dyalogscript "drawUnicodeText.apls"
dyalogscript "gameOfLife.apls"
dyalogscript "musicTest.apls"
dyalogscript "shader.apls"
dyalogscript "shapes.apls"
dyalogscript "simpleTetris.apls"
dyalogscript "stripes.apls"
dyalogscript "tesseract.apls"
dyalogscript "texture.apls"
cd ../../
