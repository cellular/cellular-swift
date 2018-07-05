#!/bin/bash

if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then

    export PATH="$HOME/.swiftenv/bin:$HOME/.swiftenv/shims:$PATH";
    swift build; swift build -c release; swift test;

else # iOS | watchOS | tvOS | macOS

    # Prepare
    xcodebuild -version;
    xcodebuild -showsdks;

    # Build Framework in Debug and Run Tests if specified
    if [ $RUN_TESTS == "YES" ]; then
        xcodebuild -project "CELLULAR.xcodeproj" -scheme "$SCHEME" -destination "$DESTINATION" -configuration Debug ONLY_ACTIVE_ARCH=NO ENABLE_TESTABILITY=YES test | xcpretty;
    else
        xcodebuild -project "CELLULAR.xcodeproj" -scheme "$SCHEME" -destination "$DESTINATION" -configuration Debug ONLY_ACTIVE_ARCH=NO build | xcpretty;
    fi
    # Build Framework in Release and Run Tests if specified
    if [ $RUN_TESTS == "YES" ]; then
        xcodebuild -project "CELLULAR.xcodeproj" -scheme "$SCHEME" -destination "$DESTINATION" -configuration Release ONLY_ACTIVE_ARCH=NO ENABLE_TESTABILITY=YES test | xcpretty;
    else
        xcodebuild -project "CELLULAR.xcodeproj" -scheme "$SCHEME" -destination "$DESTINATION" -configuration Release ONLY_ACTIVE_ARCH=NO build | xcpretty;
    fi
    # Run `pod lib lint` if specified
    if [ $POD_LINT == "YES" ]; then
        pod lib lint;
    fi
fi
