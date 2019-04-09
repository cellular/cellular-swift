<!-- markdownlint-disable MD002 MD033 MD041 -->
<h1 align="center">
  <a href="https://cellular.de">
    <img src="./.github/cellular.svg" width="300" max-width="50%">
  </a>
  <br>CELLULAR<br>
</h1>

<h4 align="center">
    A collection of utilities that we share across swift-based projects at CELLULAR.
    <br />It is a standalone module with no external dependencies.
</h4>

<p align="center">
    <a href="https://travis-ci.com/cellular/cellular-swift">
        <img src="https://travis-ci.com/cellular/cellular-swift.svg?branch=master" alt="Build Status" />
    </a>
    <a href="https://codecov.io/gh/cellular/cellular-swift">
        <img src="https://codecov.io/gh/cellular/cellular-swift/branch/master/graph/badge.svg" alt="Codecov" />
    </a>
    <a href="https://cocoapods.org/pods/cellular">
        <img src="https://img.shields.io/cocoapods/v/CELLULAR.svg" alt="CocoaPods Compatible" />
    </a>
    <a href="https://swift.org">
        <img src="https://img.shields.io/badge/swift-5.0-orange.svg" alt="Swift Version" />
    </a>
    <img src="https://img.shields.io/badge/platform-iOS%20%7C%20watchOS%20%7C%20tvOS%20%7C%20macOS%20%7C%20linux-lightgrey.svg" alt="Platform" />
</h4>
<!-- markdownlint-enable MD033 -->

## Features

### Codable

There are several extensions on `KeyedDecodingContainer`.
Most of which are heavily inspired by [Unbox](https://github.com/JohnSundell/Unbox).

#### THE PLANET

Throughout the `Codable` examples, the following struct is used:

```swift
import CELLULAR

public struct Planet: Codable {

    public var discoverer: String

    public var hasRingSystem: Bool

    public var numberOfMoons: Int

    public var distanceFromSun: Float // 10^6 km

    public var surfacePressure: Double? // bars

    public var atmosphericComposition: [String]
```

##### 1. Allows `Foundation` types to be inferred on value assignment

```swift
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        discoverer = try container.decode(forKey: .discoverer)
        // equals: discoverer = try decode(String.self, forKey: key)

        hasRingSystem = try container.decode(forKey: .hasRingSystem)
        // equals: hasRingSystem = try decode(Bool.self, forKey: key)

        numberOfMoons = try container.decode(forKey: .numberOfMoons)
        // equals: numberOfMoons = try decode(Int.self, forKey: key)
        
        distanceFromSun = try container.decode(forKey: .distanceFromSun)
        // equals: distanceFromSun = try decode(Float.self, forKey: key)
```

##### 2. Even `Optional` holding these types may be inferred

```swift
        surfacePressure = try container.decode(forKey: .surfacePressure)
        // equals: surfacePressure = try decodeIfPresent(Double.self, forKey: key)
```

##### 3. Allows instances in collections to fail decoding

```swift
        atmosphericComposition = try container.decode(forKey: .atmosphericComposition, allowInvalidElements: true) ?? []
    }
}
```

## Locking

TODO

## Storyboard

TODO

## Requirements

- iOS 9.3+ | watchOS 2.2+ | tvOS 9.2+ | macOS 10.10+ | Ubuntu 14.04+
- Swift 5.0+

## Installation

### [Swift Package Manager](https://swift.org/package-manager/)

Once you have your Swift package set up, adding CELLULAR as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/cellular/cellular-swift.git", from: "5.0")
]
```

### [CocoaPods](https://cocoapods.org)

CocoaPods is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate CELLULAR into your Xcode project using CocoaPods, specify it in your Podfile:

```ruby
pod 'CELLULAR'
```

## License

CELLULAR is released under the MIT license. [See LICENSE](https://github.com/cellular/cellular-swift/blob/master/LICENSE) for details.
