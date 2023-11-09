# swiftpm-linux-cross

This repo provides easy scripts for setting up a toolchain that allows
you to cross compile Linux binaries from a macOS machine using Swift
Package Manager. This can be useful for building your release binaries
on your host machine instead of in a potentially slower VM or docker
container.

## Replaced by [swift-sdk-generator](https://github.com/apple/swift-sdk-generator)

This repo might still be a useful example if you need to manage this
yourself, but moving forward you should use the new
[swift-sdk-generator](https://github.com/apple/swift-sdk-generator)
project instead.

## Usage

```sh
$ ./setup-swiftpm-toolchain
Done! To use run:

swift build --destination /Users/ksmiley/dev/swiftpm-linux-cross/toolchain-focal-x86_64-5.6.2/destination.json

Or for static stdlib builds run:

swift build --static-swift-stdlib --destination /Users/ksmiley/dev/swiftpm-linux-cross/toolchain-focal-x86_64-5.6.2/destination_static.json
```

See the help to customize the OS, architecture, Swift version, or
provide your own system package dependencies.

```sh
$ ./setup-swiftpm-toolchain --help
usage: setup-swiftpm-toolchain [-h] [--ubuntu-release {bionic,focal}] [--arch {x86_64,arm64}] [--swift-version SWIFT_VERSION] [packages ...]

positional arguments:
  packages              Extra OS packages your build requires

options:
  -h, --help            show this help message and exit
  --ubuntu-release {bionic,focal}
                        The target Ubuntu release you will run on
  --arch {x86_64,arm64}
                        The target architecture to build for
  --swift-version SWIFT_VERSION
                        The version of Swift you're building with and for
```

Currently this only supports targeting Ubuntu, but it should be extended
to support more operating systems.

## Installation

### With [homebrew](https://brew.sh)

```
brew install keith/formulae/swiftpm-linux-cross
```

### Manually

1. Clone this repo
2. Run any `setup-swiftpm-toolchains` inside the repo

## Matching Swift Versions

To use this your local version of Swift much match the version of Swift
the toolchain was created for. This might mean that you have to
[download a Swift toolchain](https://www.swift.org/download) instead of
using the one bundled with Xcode. If this is required you will see an
error when building like:

```
<unknown>:0: error: compiled module was created by a different version of the compiler; rebuild 'Swift' and try again
```

Once you install the matching toolchain version you can then build using
the `TOOLCHAINS` environment variable like this:

```
TOOLCHAINS=org.swift.562202206021a swift build --destination /Users/ksmiley/dev/swiftpm-linux-cross/toolchain-focal-x86_64-5.6.2/destination.json
```

You can fetch the identifier used here from the `Info.plist` bundled
with the toolchain:

```
/usr/libexec/PlistBuddy -c "print :CFBundleIdentifier" /Library/Developer/Toolchains/swift-latest.xctoolchain/Info.plist
```

This path varies either in `/Library/Developer/Toolchains` or
`~/Library/Developer/Toolchains` depending on how you install it.

## References

- [This script][script] is outdated but is a useful reference

[script]: https://github.com/apple/swift-package-manager/blob/401640a3d1553ba1a340f9b53e40b3c7442b5452/Utilities/build_ubuntu_cross_compilation_toolchain
