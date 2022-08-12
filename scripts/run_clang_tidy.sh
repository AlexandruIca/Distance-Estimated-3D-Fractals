#!/usr/bin/env sh

find src/ -regex '.*\.\(c\|h\)' -exec \
    clang-tidy -p build/ --config-file=.clang-tidy {} \;
