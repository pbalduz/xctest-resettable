// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "xctest-resettable",
    products: [
        .library(name: "TestResettable", targets: ["TestResettable"]),
    ],
    targets: [
        .target(name: "TestResettable"),
        .testTarget(
            name: "TestResettableTests",
            dependencies: ["TestResettable"]
        )
    ]
)
