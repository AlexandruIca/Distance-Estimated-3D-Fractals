#!/usr/bin/env sh

CC=gcc cmake -Bbuild -G"Ninja" -DCMAKE_BUILD_TYPE=Debug \
    -DENABLE_SANITIZER_ADDRESS=TRUE \
    -DENABLE_SANITIZER_UNDEFINED=TRUE \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=ON \
    .

pushd build/

cmake --build .

popd
