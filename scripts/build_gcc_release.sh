#!/usr/bin/env sh

CC=gcc cmake -Bbuild -G"Ninja" -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
    .

pushd build/

cmake --build .

popd
