import Foundation
import ProjectDescription
import MoodPlugin

let project = Project.makeModule(
    name: "Auth",
    organizationName: organizationName,
    product: .staticLibrary,
    bundleId: bundleID + "Auth",
    infoPlist: .extendingDefault(with: ["KAKAO_APP_KEY": "$(KAKAO_APP_KEY)"]),
    dependencies: [
        .feature(module: .Base),
        .SPM.KakaoSDKAuth,
        .SPM.KakaoSDKUser
    ],
    settings: .base("Auth"),
    hasTest: true,
    hasDemo: true
)
