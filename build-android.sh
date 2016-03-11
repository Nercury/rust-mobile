#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BUILD_DIR=`pwd`

NDK_ROOT=$(awk -F "=" '/ndk.dir/ {print $2}' ${SCRIPT_DIR}/local.properties)
if [ $? -ne 0 ]; then
    echo "failed to read ndk location from local.properties file"
    exit 1
fi

echo "ndk found at ${NDK_ROOT}"

mkdir -p build-android
cd build-android
mkdir -p standalone-ndk
cd standalone-ndk

ARCHS=()
TOOLCHAINS=()
RUST_TARGETS=()

ARCHS+=("arm")
TOOLCHAINS+=("arm-linux-androideabi-4.9")
RUST_TARGETS+=("arm-linux-androideabi")

ARCHS+=("x86")
TOOLCHAINS+=("x86-4.9")
RUST_TARGETS+=("i686-linux-android")

#ARCHS+=("mips")
#TOOLCHAINS+=("mipsel-linux-android")
#RUST_TARGETS+= does not exist yet

ARCHS+=("arm64")
TOOLCHAINS+=("aarch64-linux-android-4.9")
RUST_TARGETS+=("aarch64-linux-android")

#ARCHS+=("x86_64")
#TOOLCHAINS+=("x86_64")
#RUST_TARGETS+= does not exist yet

#ARCHS+=("mips64")
#TOOLCHAINS+=("mips64el-linux-android")
#RUST_TARGETS+= does not exist yet

for i in "${!TOOLCHAINS[@]}"
do
    ARCH=${ARCHS[$i]}
    TOOLCHAIN=${TOOLCHAINS[$i]}
    mkdir -p ${ARCH}
    ${NDK_ROOT}/build/tools/make-standalone-toolchain.sh \
        --platform=android-21 --arch=${ARCH} --toolchain=${TOOLCHAIN} --install-dir=${ARCH}
done

cd ${BUILD_DIR}/build-android

../rust/configure \
    --target=arm-linux-androideabi,i686-linux-android,aarch64-linux-android \
    --enable-ccache \
    --disable-optimize-tests \
    --disable-docs \
    --arm-linux-androideabi-ndk=${BUILD_DIR}/build-android/standalone-ndk/arm \
    --i686-linux-android-ndk=${BUILD_DIR}/build-android/standalone-ndk/x86 \
    --aarch64-linux-android-ndk=${BUILD_DIR}/build-android/standalone-ndk/arm64 \
    --prefix=${BUILD_DIR}/out-android

if [ $? -ne 0 ]; then
    echo "./configure for Android failed, aborting"
    exit 1
fi

make -j8

if [ $? -ne 0 ]; then
    echo "make for Android failed, aborting"
    exit 1
fi

make install

if [ $? -ne 0 ]; then
    echo "make install for Android failed, aborting"
    exit 1
fi
