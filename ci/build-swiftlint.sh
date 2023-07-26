#!/bin/bash

set -euo pipefail
set -x

readonly os=$1
readonly arch=$2

toolchain_id=$(./ci/install-macos-toolchain.sh)

./setup-swiftpm-toolchain --ubuntu-release "$os" --arch "$arch"
readonly destination=$PWD/toolchain-$os-$arch-5.6.2/destination.json
readonly binary_path=$PWD/swiftlint

cd "$(mktemp -d)"
git clone --recursive --depth 1 https://github.com/realm/SwiftLint.git
cd SwiftLint

TOOLCHAINS="$toolchain_id" swift build --destination "$destination"
cp ./.build/debug/swiftlint "$binary_path"
