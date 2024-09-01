import Foundation
import ProjectDescription
import MoodPlugin

let project = Project.makeModule(
    name: "ThirdPartyLibrary",
    organizationName: organizationName,
    product: .framework,
    bundleId: bundleID + "ThirdPartyLibrary",
    dependencies: [
        .SPM.LinkNavigator,
        .SPM.Alamofire,
        .SPM.Dependencies,
        .SPM.KakaoSDKAuth,
        .SPM.KakaoSDKUser,
        .SPM.NaverThirdPartyLogin
    ],
    settings: .core()
)
