// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "StatusIconManager",
    platforms: [
        .macOS(.v10_13),
    ],
    products: [
        .library(name: "StatusIconManager", targets: ["StatusIconManager"]),
        .library(name: "RxStatusIconManager", targets: ["RxStatusIconManager"])
    ],
    dependencies: [
        .package(url: "https://github.com/ReactiveX/RxSwift.git", .upToNextMajor(from: "6.0.0"))
    ],
    targets: [
        .target(name: "StatusIconManager", dependencies: []),
        .target(name: "RxStatusIconManager",
                dependencies: ["StatusIconManager", "RxSwift",
                               .product(name: "RxCocoa", package: "RxSwift")]),
    ],
    swiftLanguageVersions: [.v5]
)
