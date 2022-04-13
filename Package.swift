// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "UniversalTextEditor",
    platforms: [
        .iOS(.v15),
        .macOS(.v12),
    ],
    products: [
        .library(name: "UniversalTextEditor", targets: ["UniversalTextEditor"]),
    ],
    dependencies: [
//        .package(url: "https://github.com/apple/swift-markdown", .branchItem("main")),
        .package(url: "https://github.com/johnxnguyen/Down", .upToNextMinor(from: "0.11.0")),
    ],
    targets: [
        .target(
            name: "UniversalTextEditor",
            dependencies: [
                .product(name: "Down", package: "Down"),
            ],
            path: "Source"
        ),
        .testTarget(
            name: "UniversalTextEditorTests",
            dependencies: [
                .target(name: "UniversalTextEditor"),
            ],
            path: "Tests"
        ),
    ]
)
