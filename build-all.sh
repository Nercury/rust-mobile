#!/usr/bin/env bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BUILD_DIR=`pwd`
RUST_VERSION=nightly-2016-02-04

echo "ensuring multirust has ${RUST_VERSION}..."

RUST_COMMIT="$( ${SCRIPT_DIR}/prepare-multirust.sh ${RUST_VERSION} )"
if [ $? -ne 0 ]; then
    echo "failed to get commit hash: ${RUST_COMMIT}"
    exit 1
fi

echo "the commit for ${RUST_VERSION} is ${RUST_COMMIT}"

echo "checking out rust source..."

${SCRIPT_DIR}/checkout-rust-source.sh ${RUST_COMMIT}
if [ $? -ne 0 ]; then
    echo "checkout failed, aborting"
    exit 1
fi

echo "building for iOS..."

${SCRIPT_DIR}/build-ios.sh
if [ $? -ne 0 ]; then
    echo "iOS build failed"
    exit 1
fi

echo "building for Android..."

${SCRIPT_DIR}/build-android.sh
if [ $? -ne 0 ]; then
    echo "Android build failed"
    exit 1
fi