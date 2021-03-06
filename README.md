## rust-mobile

Collection of scripts to build Rust for iOS and Android platforms.

**Hey! This project is OUTDATED**. Nowadays you can get pre-built std library using rustup!

## Requirements

- Scripts were tested only on OSX
- Multirust [`https://github.com/brson/multirust`](https://github.com/brson/multirust)
- NDK (and modifying `local.properties` if you will be compiling for Android)
- XCode if you will be compiling for iOS

## Building

```bash
git clone https://github.com/Nercury/rust-mobile.git rust-mobile
```

For Android, have NDK installed and create and edit local.properties file:

```bash
cp local.properties.example local.properties
```

For iOS, it's enough to make sure XCode can build iOS projects. If not building for iOS, it is easy
to comment out relevant lines in `build-all.sh`.

When ready, run it all with (from `rust-build` dir, although it does not matter much):

```bash
mkdir rust-build
cd rust-build
../rust-mobile/build-all.sh
```

All immediate files and the output will be places in `rust-build` dir.

## Usage

To the resulting binaries should be integrated into multirust, so you can now compile
things with (in your project dir):

```bash
multirust override ios
cargo build --target x86_64-apple-ios
```

Or:

```bash
multirust override android
cargo build --target arm-linux-androideabi --release
```

For the exact list of output platforms, look at `build-android.sh` and `build-ios.sh` scripts.

## Used Resources

- [Compiling Rust to an Android Target][compiling-to-android]
- [Building an iOS app in rust][ios-in-rust]
- [Everything you need to know about cross compiling Rust programs!][japaric-rust-cross]
- [Rust nightly for Android][rust-nightly-for-android]

[compiling-to-android]: https://ghotiphud.github.io/rust/android/cross-compiling/2016/01/06/compiling-rust-to-android.html
[ios-in-rust]: https://www.bignerdranch.com/blog/building-an-ios-app-in-rust-part-1/
[japaric-rust-cross]: https://github.com/japaric/rust-cross
[rust-nightly-for-android]: https://users.rust-lang.org/t/rust-nightly-for-android/645/3
