#!/bin/bash

if [[ "$TRAVIS_OS_NAME" == "linux" ]]; then
    eval "$(curl -sL https://swiftenv.fuller.li/install.sh)";
else
    gem install cocoapods --no-document --quiet;
fi
