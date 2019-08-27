#!/bin/bash
set -e; # Fail on first error

if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then

    export PATH="$HOME/.swiftenv/bin:$HOME/.swiftenv/shims:$PATH";
    swift build; swift build -c release; swift test;

else # iOS | watchOS | tvOS | macOS

    # Prepare
    set -o pipefail; # xcpretty
    xcodebuild -version;
    xcodebuild -showsdks;

    # Build Framework in Debug and Run Tests if specified
    if [ $RUN_TESTS == "NO" ]; then
        xcodebuild -project CELLULAR.xcodeproj -scheme CELLULAR-Package -destination "$DESTINATION" -configuration Release ONLY_ACTIVE_ARCH=NO | xcpretty;
    else
        xcodebuild test -project CELLULAR.xcodeproj -scheme CELLULAR-Package -destination "$DESTINATION" -configuration Release ONLY_ACTIVE_ARCH=NO | xcpretty;
    fi
    # Run `pod lib lint` if specified
    if [ $POD_LINT == "YES" ]; then
        pod lib lint;
    fi
fi
