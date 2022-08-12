#!/usr/bin/env sh

pushd build

rm -rf src/ CMakeFiles/
rm CMakeCache.txt .ninja* *.ninja cmake* compile_commands.json

popd
