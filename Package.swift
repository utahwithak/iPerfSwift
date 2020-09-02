// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "iPerfSwift",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "iPerfSwift",
            targets: ["iperf", "iPerfSwift"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(name: "iperf",
                dependencies: [],
                path: "External/iperf/src",
                exclude: [
                    "t_api.c",
                    "t_auth.c",
                    "t_timer.c",
                    "t_units.c",
                    "t_uuid.c",
                    "main.c"
                    ]
        ),
        .target(
            name: "iPerfSwift",
            dependencies: ["iperf"],
            path: "Sources/iPerfSwift"),
        .testTarget(
            name: "iPerfSwiftTests",
            dependencies: ["iPerfSwift"]),
    ]
)
