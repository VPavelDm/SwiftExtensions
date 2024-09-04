// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftExtensions",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SwiftExtensions",
            targets: ["SwiftExtensions"]),
        .library(
            name: "CoreNetwork",
            targets: ["CoreNetwork"]),
    ],
    targets: [

        // MARK: -

        .target(
            name: "SwiftExtensions"),

            .testTarget(
                name: "SwiftExtensionsTests",
                dependencies: ["SwiftExtensions"]),

            .target(
                name: "CoreNetwork"),
    ]
)
