BUILD_DIR=`pwd`

OUTPUT="$( multirust override $1 )"
if [ $? -ne 0 ]; then
    echo "multirust override failed:${OUTPUT}"
    exit 1
fi

multirust update ios --link-local ${BUILD_DIR}/out-ios
ln -s $HOME/.multirust/toolchains/$1/bin/cargo ${BUILD_DIR}/out-ios/bin

multirust update android --link-local ${BUILD_DIR}/out-android
ln -s $HOME/.multirust/toolchains/$1/bin/cargo ${BUILD_DIR}/out-android/bin

exit 0
