// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "UIKitExt",
  platforms: [
    .iOS(.v11),
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
      path: "Sources",
      swiftSettings: [
        .define("DISABLE_LAYER_PROPERTY_PROXY")
      ]
    ),
  ],
  swiftLanguageVersions: [.v5]
)
