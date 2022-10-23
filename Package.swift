// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "xctest-resettable",
    products: [
        .library(
            name: "xctest-resettable",
            targets: ["xctest-resettable"]
        ),
    ],
    targets: [
        .target(name: "xctest-resettable")
    ]
)
