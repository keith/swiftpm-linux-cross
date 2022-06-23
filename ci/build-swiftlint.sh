#!/bin/bash

set -euo pipefail
set -x

wget https://download.swift.org/swift-5.6.2-release/xcode/swift-5.6.2-RELEASE/swift-5.6.2-RELEASE-osx.pkg
installer -target CurrentUserHomeDirectory -pkg swift-5.6.2-RELEASE-osx.pkg

toolchain_id=$(/usr/libexec/PlistBuddy -c "print :CFBundleIdentifier" ~/Library/Developer/Toolchains/swift-latest.xctoolchain/Info.plist)

./setup-toolchain
readonly destination=$PWD/toolchain-focal-x86_64-5.6.2/destination.json
readonly binary_path=$PWD/swiftlint

cd "$(mktemp -d)"
git clone --branch ks/switch-to-swiftpm-conditional-dependencies-api --recursive --depth 1 https://github.com/realm/SwiftLint.git
cd SwiftLint

TOOLCHAINS="$toolchain_id" swift build --destination "$destination"
cp ./.build/debug/swiftlint "$binary_path"
