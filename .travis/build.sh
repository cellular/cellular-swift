#!/bin/bash

if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then
    swift build;
    swift build -c release;
    swift test;
else
    set -o pipefail;
    xcodebuild -version;
    xcodebuild -showsdks;
    swift package generate-xcodeproj;

    PROJECT=CELLULAR.xcodeproj;
    SCHEME=CELLULAR-Package;

    # Build Framework in Debug and Run Tests if specified
    if [ $RUN_TESTS == "YES" ]; then
      xcodebuild -project "$PROJECT" -scheme "$SCHEME" -destination "$DESTINATION" -configuration Debug ONLY_ACTIVE_ARCH=NO ENABLE_TESTABILITY=YES test | xcpretty;
    else
      xcodebuild -project "$PROJECT" -scheme "$SCHEME" -destination "$DESTINATION" -configuration Debug ONLY_ACTIVE_ARCH=NO build | xcpretty;
    fi
    # Build Framework in Release and Run Tests if specified
    if [ $RUN_TESTS == "YES" ]; then
      xcodebuild -project "$PROJECT" -scheme "$SCHEME" -destination "$DESTINATION" -configuration Release ONLY_ACTIVE_ARCH=NO ENABLE_TESTABILITY=YES test | xcpretty;
    else
      xcodebuild -project "$PROJECT" -scheme "$SCHEME" -destination "$DESTINATION" -configuration Release ONLY_ACTIVE_ARCH=NO build | xcpretty;
    fi
    # Run `pod lib lint` if specified
    if [ $POD_LINT == "YES" ]; then
      pod lib lint;
    fi
fi
