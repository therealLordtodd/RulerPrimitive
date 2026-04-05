// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "RulerPrimitive",
    platforms: [
        .macOS(.v15),
        .iOS(.v17),
    ],
    products: [
        .library(name: "RulerPrimitive", targets: ["RulerPrimitive"]),
    ],
    targets: [
        .target(name: "RulerPrimitive"),
        .testTarget(
            name: "RulerPrimitiveTests",
            dependencies: ["RulerPrimitive"]
        ),
    ]
)
