#!/bin/bash

set -euo pipefail
set -x

./setup-toolchain
destination=$PWD/toolchain-focal-x86_64-5.6.2/destination.json

git clone --recursive --depth 1 https://github.com/realm/SwiftLint.git
cd SwiftLint

TOOLCHAINS=org.swift.562202206021a swift build --destination "$destination"
cp ./.build/debug/swiftlint ..
