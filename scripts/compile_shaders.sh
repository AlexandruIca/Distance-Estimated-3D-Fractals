#!/usr/bin/env sh

find src/ -regex '.*\.glsl' -exec \
    dependencies/shdc -i {} -o {}.h -l glsl330 \;
