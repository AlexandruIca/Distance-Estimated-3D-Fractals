#!/usr/bin/env sh

SOKOL_REPO="https://raw.githubusercontent.com/floooh/sokol/master"
TOOLS_REPO="https://raw.githubusercontent.com/floooh/sokol-tools-bin/master"

fetch_file() {
    curl "${SOKOL_REPO}/$1" > $1
}

fetch_binary() {
    curl "${TOOLS_REPO}/$1?raw=true" > $2
    chmod +x $2
}

fetch_file "LICENSE"
fetch_file "sokol_app.h"
fetch_file "sokol_gfx.h"
fetch_file "sokol_glue.h"
fetch_file "sokol_time.h"
fetch_binary "bin/linux/sokol-shdc" shdc
