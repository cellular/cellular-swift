// swift-tools-version:4.1
import PackageDescription

let package = Package(
    name: "CELLULAR",
    products: [
        .library(name: "CELLULAR", targets: ["Result", "Codable", "Locking", "Storyboard"])
    ],
    targets: [
        .target(name: "Result", path: "Sources/Result"),
        .target(name: "Codable", path: "Sources/Codable"),
        .target(name: "Locking", path: "Sources/Locking"),
        .target(name: "Storyboard", path: "Sources/Storyboard"),
        .testTarget(
            name: "UnitTests",
            dependencies: ["Result", "Codable", "Locking", "Storyboard"]
        )
    ]
)
