#!/usr/bin/env sh

find src/ -regex '.*\.\(c\|h\)' -exec clang-format --dry-run -Werror {} \;
