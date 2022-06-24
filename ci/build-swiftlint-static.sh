#!/bin/bash

set -euo pipefail
set -x

readonly os=$1
readonly arch=$2

toolchain_id=$(./ci/install-macos-toolchain.sh)

./setup-toolchain --ubuntu-release "$os" --arch "$arch"
readonly destination=$PWD/toolchain-$os-$arch-5.6.2/destination_static.json
readonly binary_path=$PWD/swiftlint

cd "$(mktemp -d)"
git clone --branch ks/switch-to-swiftpm-conditional-dependencies-api --recursive --depth 1 https://github.com/realm/SwiftLint.git
cd SwiftLint

TOOLCHAINS="$toolchain_id" swift build --destination "$destination" --static-swift-stdlib -Xlinker -lCFURLSessionInterface -Xlinker -lCFXMLInterface -Xlinker -lcurl -Xlinker -lxml2  -Xlinker -lz -Xlinker -llzma -Xlinker -licuuc -Xlinker -licudata
cp ./.build/debug/swiftlint "$binary_path"
