// swift-tools-version: 5.9
import PackageDescription

#if TUIST
    import ProjectDescription

    let packageSettings = PackageSettings(
        productTypes: [:]
    )
#endif

let package = Package(
    name: "Mood",
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-dependencies", branch: "main"),
        .package(url: "https://github.com/interactord/LinkNavigator.git", branch: "main"),
        .package(url: "https://github.com/kean/NukeUI", branch: "main"),
        .package(url: "https://github.com/kakao/kakao-ios-sdk", branch: "master"),
    ]
)
