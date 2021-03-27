// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftWKBridge",
    platforms: [
        .macOS(.v10_14),
        .iOS(.v10)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "SwiftWKBridge",
            targets: ["SwiftWKBridge"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "SwiftWKBridge",
            dependencies: [],
            resources: [
                .process("Assets")
            ]),
        .testTarget(
            name: "SwiftWKBridgeTests",
            dependencies: ["SwiftWKBridge"]),
    ]
)
