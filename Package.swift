// swift-tools-version: 6.0

import PackageDescription

let package = Package(
  name: "pocket-bell",
  platforms: [
    .iOS(.v17),
  ],
  products: [
    .library(name: "APIClient", targets: ["APIClient"]),
    .library(name: "APIClientLive", targets: ["APIClientLive"]),
    .library(name: "AppFeature", targets: ["AppFeature"]),
    .library(name: "DesignSystem", targets: ["DesignSystem"]),
    .library(name: "PhoneNumberFeature", targets: ["PhoneNumberFeature"]),
    .library(name: "PocketBellFeature", targets: ["PocketBellFeature"]),
    .library(name: "SendFeature", targets: ["SendFeature"]),
    .library(name: "SharedModels", targets: ["SharedModels"]),
    .library(name: "VerifyFeature", targets: ["VerifyFeature"]),
  ],
  dependencies: [
    .package(url: "https://github.com/firebase/firebase-ios-sdk", from: "11.3.0"),
    .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.4.1"),
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.15.0"),
    .package(url: "https://github.com/tomokisun/swift-pocket-bell-two-touch-parser", from: "0.1.0"),
  ],
  targets: [
    .target(name: "APIClient", dependencies: [
      "SharedModels",
      .product(name: "Dependencies", package: "swift-dependencies"),
      .product(name: "DependenciesMacros", package: "swift-dependencies"),
    ]),
    .target(name: "APIClientLive", dependencies: [
      "APIClient",
      .product(name: "FirebaseFirestore", package: "firebase-ios-sdk"),
    ]),
    .target(name: "AppFeature", dependencies: [
      "APIClient",
      "SendFeature",
      "VerifyFeature",
      "PocketBellFeature",
      "PhoneNumberFeature",
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),
    .target(name: "DesignSystem", dependencies: []),
    .target(name: "PhoneNumberFeature", dependencies: [
      "DesignSystem",
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),
    .target(name: "PocketBellFeature", dependencies: [
      "DesignSystem",
      "SharedModels",
      .product(name: "TwoTouchParser", package: "swift-pocket-bell-two-touch-parser"),
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),
    .target(name: "SendFeature", dependencies: [
      "DesignSystem",
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),
    .target(name: "SharedModels", dependencies: []),
    .target(name: "VerifyFeature", dependencies: [
      "DesignSystem",
      .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
    ]),
  ]
)
