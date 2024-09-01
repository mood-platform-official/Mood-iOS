import Foundation
import ProjectDescription
import MoodPlugin

private let infoPlist: [String: Plist.Value] = [
//    "CFBundleShortVersionString": "1.0",
//    "CFBundleVersion": "1",
//    "CFBundleDisplayName": "$(PRODUCT_NAME)",
//    "UILaunchStoryboardName": "LaunchScreen",
//    "UIUserInterfaceStyle": "Light",
//    "NSAppTransportSecurity": ["NSAllowsArbitraryLoads": true],
//    "NSPhotoLibraryAddUsageDescription": "사진첩 접근 권한 요청",
//    "UIApplicationSupportsIndirectInputEvents": true,
//    "UISupportedInterfaceOrientations": ["UIInterfaceOrientationPortrait"],
//    "LSSupportsOpeningDocumentsInPlace": true,
//    "BASE_URL": "${BASE_URL}",
//    "USER_AGENT": "${USER_AGENT}"
    "UISupportedInterfaceOrientations": ["UIInterfaceOrientationPortrait"],
    "KAKAO_APP_KEY": "$(KAKAO_APP_KEY)",
    "NAVER_CLIENT_ID": "$(NAVER_CLIENT_ID)",
    "NAVER_CLIENT_SECRET": "$(NAVER_CLIENT_SECRET)",
    "UILaunchScreen": [:],
    "UIUserInterfaceStyle": "Light",
    "BASE_URL": "${BASE_URL}",
    "CFBundleURLTypes": [[
        "CFBundleTypeRole": "Editor",
        "CFBundleURLSchemes": ["com.mood.Mood"]
    ]]
]

let project = Project.makeModule(
    name: "Auth",
    organizationName: organizationName,
    product: .staticLibrary,
    bundleId: bundleID + "Auth",
    infoPlist: .extendingDefault(with: infoPlist),
    dependencies: [
        .feature(module: .Base)
    ],
    settings: .base("Auth"),
    hasTest: true,
    hasDemo: true
)
