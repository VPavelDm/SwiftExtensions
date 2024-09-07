// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftExtensions",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "CoreNetwork",
            targets: ["CoreNetwork"]),
        .library(
            name: "CoreUI",
            targets: ["CoreUI"])
    ],
    targets: [

        // MARK: -

        .target(
            name: "CoreNetwork"),

            .target(
                name: "CoreUI"),
    ]
)
