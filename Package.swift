// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "xctest-resettable",
    platforms: [
        .iOS(.v13),
        .macCatalyst(.v13),
        .macOS(.v10_15),
        .tvOS(.v13),
        .watchOS(.v6)
    ],
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
