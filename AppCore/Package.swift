// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppCore",
    platforms: [.iOS(.v15),.macOS(.v12)],
    products: [
        .library(
            name: "NetworkManager",
            targets: ["NetworkManager"]),
        .library(
            name: "MovieListRepository",
            targets: ["MovieListRepository"]),
        .library(
            name: "MovieListUseCases",
            targets: ["MovieListUseCases"]),
        
    ],
    targets: [
        .target(
            name: "NetworkManager"),
        .testTarget(
            name: "NetworkManagerTests",
            dependencies: ["NetworkManager"]
        ),
        .target(
            name: "MovieListRepository"),
        .testTarget(
            name: "MovieListRepositoryTests",
            dependencies: ["NetworkManager", "MovieListRepository"]
        ),
        .target(
            name: "MovieListUseCases",
            dependencies: ["MovieListRepository"]),
        .testTarget(
            name: "MovieListUseCasesTests",
            dependencies: ["MovieListUseCases", "MovieListRepository"]
        ),
        
    ]
)
