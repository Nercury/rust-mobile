#!/usr/bin/env bash

BUILD_DIR=`pwd`

mkdir -p build-ios
cd build-ios
../rust/configure \
    --target=armv7-apple-ios,armv7s-apple-ios,i386-apple-ios,aarch64-apple-ios,x86_64-apple-ios \
    --prefix=${BUILD_DIR}/out-ios

if [ $? -ne 0 ]; then
    echo "./configure for iOS failed, aborting"
    exit 1
fi

make -j8

if [ $? -ne 0 ]; then
    echo "make for iOS failed, aborting"
    exit 1
fi

make install

if [ $? -ne 0 ]; then
    echo "make install for iOS failed, aborting"
    exit 1
fi