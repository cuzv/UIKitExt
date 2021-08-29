// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UIKitExt",
    platforms: [
        .iOS(.v10),
    ],
    products: [
        .library(name: "UIKitExt", targets: ["UIKitExt"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "UIKitExt",
            dependencies: [
            ],
            path: "Sources"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
