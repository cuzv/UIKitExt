// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "UIKitExt",
  platforms: [
    // https://developer.apple.com/documentation/xcode-release-notes/xcode-13-release-notes
    // ```
    // Swift libraries depending on Combine may fail to build for targets including armv7 and i386 architectures. (82183186, 82189214)
    // Workaround: Use an updated version of the library that isn’t impacted (if available) or remove armv7 and i386 support (for example, increase the deployment target of the library to iOS 11 or higher).
    //```
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
      path: "Sources"
    ),
  ],
  swiftLanguageVersions: [.v5]
)
