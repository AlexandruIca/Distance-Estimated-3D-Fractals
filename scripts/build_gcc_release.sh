#!/usr/bin/env sh

CC=gcc cmake -Bbuild -G"Ninja" -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
    .

cd build/

cmake --build .

cd ..
