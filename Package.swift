// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UserInterface",
    platforms: [
        .iOS(.v10),
    ],
    products: [
        .library(name: "UserInterface", targets: ["UserInterface"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "UserInterface",
            dependencies: [
            ],
            path: "Sources"
        ),
    ],
    swiftLanguageVersions: [.v5]
)
