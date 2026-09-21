// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "flutter_infonline_library",
    platforms: [.iOS("13.0")],
    products: [
        .library(name: "flutter-infonline-library", targets: ["flutter_infonline_library"])
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework")
    ],
    targets: [
        .target(
            name: "flutter_infonline_library",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework"),
                "INFOnlineLibrary"
            ]
        ),
        .binaryTarget(
            name: "INFOnlineLibrary",
            path: "Frameworks/INFOnlineLibrary.xcframework"
        )
    ]
)
