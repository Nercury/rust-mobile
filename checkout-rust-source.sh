#!/usr/bin/env bash

BUILD_DIR=`pwd`

if [ ! -d "rust" ]; then
    git clone https://github.com/rust-lang/rust.git rust
    if [ $? -ne 0 ]; then
        echo "failed to clone rust"
        exit 1
    fi
fi

cd rust
git checkout -b snapshot

git reset --hard $1
if [ $? -ne 0 ]; then
    echo "failed to switch to commit $1"
    exit 1
fi

git submodule update --init --recursive

exit 0