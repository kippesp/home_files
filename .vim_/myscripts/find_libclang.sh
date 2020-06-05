#!/bin/bash

# Use 'llvm-config --libdir' to locate libclang.so
# On success, outputs the path to the libclang directory.

LIBDIR=`llvm-config --libdir 2> /dev/null`

if [ ! $? -eq 0 ]; then
    exit 1
fi

LIBCLANG_PATH="$LIBDIR/libclang.so"

if [ -e "$LIBCLANG_PATH" ]; then
    echo -n $LIBCLANG_PATH
    exit 0
else
    exit 1
fi
