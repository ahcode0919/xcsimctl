// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "xcsimctl-server",
    platforms: [
        .macOS(.v11)
    ],
    dependencies: [
        .package(url: "https://github.com/ahcode0919/Fast.git", from: "0.0.5"),
        .package(url: "https://github.com/ahcode0919/swift-shell.git", from: "0.0.4"),
        .package(url: "https://github.com/vapor/vapor.git", from: "4.61.1"),
    ],
    targets: [
        .target(
            name: "App",
            dependencies: [
                .product(name: "Fast", package: "Fast"),
                .product(name: "SwiftShell", package: "swift-shell"),
                .product(name: "Vapor", package: "vapor")
            ]
        ),
        .target(name: "Run", dependencies: [.target(name: "App")]),
        .testTarget(name: "AppTests", dependencies: [
            .target(name: "App"),
            .product(name: "XCTVapor", package: "vapor"),
        ])
    ]
)
