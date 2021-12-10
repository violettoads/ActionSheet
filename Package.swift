// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ActionSheet",
    platforms: [.iOS("13.0")],
    products: [
        .library(
            name: "ActionSheet",
            targets: ["ActionSheet"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "ActionSheet",
            dependencies: []),
        .testTarget(
            name: "ActionSheetTests",
            dependencies: ["ActionSheet"]),
    ]
)
