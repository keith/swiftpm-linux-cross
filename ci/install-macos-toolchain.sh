#!/bin/bash

set -euo pipefail
set -x

wget https://download.swift.org/swift-5.6.2-release/xcode/swift-5.6.2-RELEASE/swift-5.6.2-RELEASE-osx.pkg >&2
installer -target CurrentUserHomeDirectory -pkg swift-5.6.2-RELEASE-osx.pkg >&2

/usr/libexec/PlistBuddy -c "print :CFBundleIdentifier" ~/Library/Developer/Toolchains/swift-latest.xctoolchain/Info.plist
