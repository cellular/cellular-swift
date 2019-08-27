// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "CELLULAR",
    products: [
        .library(name: "CELLULAR", targets: ["Codable", "Locking", "Storyboard"])
    ],
    targets: [
        .target(name: "Codable"),
        .target(name: "Locking"),
        .target(name: "Storyboard"),
        .testTarget(name: "CELLULARTests", dependencies: ["Codable", "Locking", "Storyboard"])
    ]
)
