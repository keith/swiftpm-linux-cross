#!/bin/bash

set -euo pipefail
set -x

readonly os=$1

toolchain_id=$(./ci/install-macos-toolchain.sh)

./setup-toolchain --ubuntu-release "$os"
readonly destination=$PWD/toolchain-$os-x86_64-5.6.2/destination_static.json
readonly binary_path=$PWD/swiftlint

cd "$(mktemp -d)"
git clone --branch ks/switch-to-swiftpm-conditional-dependencies-api --recursive --depth 1 https://github.com/realm/SwiftLint.git
cd SwiftLint

TOOLCHAINS="$toolchain_id" swift build --destination "$destination" --static-swift-stdlib -c release -Xlinker -lCFURLSessionInterface -Xlinker -lCFXMLInterface -Xlinker -lcurl -Xlinker -lxml2
cp ./.build/release/swiftlint "$binary_path"
