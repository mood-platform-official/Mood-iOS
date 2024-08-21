import Foundation
import ProjectDescription
import MoodPlugin

let project = Project.makeModule(
    name: "Auth",
    organizationName: organizationName,
    product: .staticLibrary,
    bundleId: bundleID + "Auth",
    infoPlist: .extendingDefault(with: [
        "UISupportedInterfaceOrientations": ["UIInterfaceOrientationPortrait"],
        "KAKAO_APP_KEY": "$(KAKAO_APP_KEY)",
        "NAVER_CLIENT_ID": "$(NAVER_CLIENT_ID)",
        "NAVER_CLIENT_SECRET": "$(NAVER_CLIENT_SECRET)",
        "UILaunchScreen": [:],
        "UIUserInterfaceStyle": "Light",
        "BASE_URL": "${BASE_URL}",
    ]),
    dependencies: [
        .feature(module: .Base),
        .SPM.KakaoSDKAuth,
        .SPM.KakaoSDKUser,
        .SPM.NaverThirdPartyLogin
    ],
    settings: .base("Auth"),
    hasTest: true,
    hasDemo: true
)
