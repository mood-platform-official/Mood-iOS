import ProjectDescription
import MoodPlugin

private let infoPlist: [String: Plist.Value] = [
    "CFBundleShortVersionString": "1.0",
    "CFBundleVersion": "1",
    "CFBundleDisplayName": "$(PRODUCT_NAME)",
    "UILaunchStoryboardName": "LaunchScreen",
    "UIUserInterfaceStyle": "Light",
    "NSAppTransportSecurity": ["NSAllowsArbitraryLoads": true],
    "NSPhotoLibraryAddUsageDescription": "사진첩 접근 권한 요청",
    "UIApplicationSupportsIndirectInputEvents": true,
    "UISupportedInterfaceOrientations": ["UIInterfaceOrientationPortrait"],
    "LSSupportsOpeningDocumentsInPlace": true,
    "BASE_URL": "${BASE_URL}",
    "USER_AGENT": "${USER_AGENT}"
]

let project = Project.makeModule(
    name: appName,
    organizationName: organizationName,
    product: .app,
    bundleId: bundleID,
    dependencies: [
        .feature(module: .Auth)
    ],
    settings: .main
)


