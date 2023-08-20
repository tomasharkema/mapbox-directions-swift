// swift-tools-version:5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MapboxDirections",
    platforms: [
        .macOS(.v10_14), .iOS(.v14), .watchOS(.v5), .tvOS(.v14)
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "MapboxDirections",
            targets: ["MapboxDirections"]
        ),
        .executable(
            name: "mapbox-directions-swift",
            targets: ["MapboxDirectionsCLI"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/tomasharkema/Polyline.git", branch: "feature/module-collision"),
        .package(url: "https://github.com/mapbox/turf-swift.git", from: "2.6.1"),
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.0.0"),
        .package(url: "https://github.com/AliSoftware/OHHTTPStubs", from: "9.1.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "MapboxDirections",
            dependencies: [
                .product(name: "PolylineLib", package: "Polyline"),
                .product(name: "Turf", package: "turf-swift")
            ],
            exclude: ["Info.plist"]),
        .testTarget(
            name: "MapboxDirectionsTests",
            dependencies: [
                "MapboxDirections",
                .product(name: "PolylineLib", package: "Polyline"),
                .product(name: "Turf", package: "turf-swift"),
                .product(name:  "OHHTTPStubsSwift", package: "OHHTTPStubs", condition: .when(platforms: [.macOS, .iOS, .tvOS, .watchOS]))
            ],
            exclude: ["Info.plist"],
            resources: [
                .process("Fixtures"),
            ]),
        .executableTarget(
            name: "MapboxDirectionsCLI",
            dependencies: [
                "MapboxDirections",
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]),
    ]
)
