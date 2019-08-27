// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "CELLULAR",
    products: [
        .library(name: "CELLULAR", targets: ["CELLULAR"])
    ],
    targets: [
        .target(name: "CELLULAR"),
        .testTarget(name: "CELLULARTests", dependencies: ["CELLULAR"])
    ]
)
