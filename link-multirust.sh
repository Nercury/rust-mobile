BUILD_DIR=`pwd`

OUTPUT="$( multirust override $1 )"
if [ $? -ne 0 ]; then
    echo "multirust override failed:${OUTPUT}"
    exit 1
fi

multirust update ios --link-local ${BUILD_DIR}/out-ios
rm ${BUILD_DIR}/out-ios/bin/cargo 2> /dev/null
ln -s $HOME/.multirust/toolchains/nightly/bin/cargo ${BUILD_DIR}/out-ios/bin/cargo

multirust update android --link-local ${BUILD_DIR}/out-android
rm ${BUILD_DIR}/out-android/bin/cargo 2> /dev/null
ln -s $HOME/.multirust/toolchains/nightly/bin/cargo ${BUILD_DIR}/out-android/bin/cargo

exit 0
