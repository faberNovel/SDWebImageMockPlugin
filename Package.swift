// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "SDWebImageMockPlugin",
    platforms: [
        .iOS(.v9),
        .tvOS(.v9)
    ],
    products: [
        .library(
            name: "SDWebImageMockPlugin",
            targets: ["SDWebImageMockPlugin"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/SDWebImage/SDWebImage.git", from: "5.0.0")
    ],
    targets: [
        .target(
            name: "SDWebImageMockPlugin",
            dependencies: []
        )
    ]
)
