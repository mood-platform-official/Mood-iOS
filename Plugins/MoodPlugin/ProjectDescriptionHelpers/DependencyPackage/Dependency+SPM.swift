import ProjectDescription

public extension TargetDependency {
    enum SPM {}
}

public extension TargetDependency.SPM {
    static let NukeUI = TargetDependency.external(name: "NukeUI")
    static let Dependencies = TargetDependency.external(name: "Dependencies")
    static let LinkNavigator = TargetDependency.external(name: "LinkNavigator")
    static let Alamofire = TargetDependency.external(name: "Alamofire")
    static let KakaoSDKAuth = TargetDependency.external(name: "KakaoSDKAuth")
    static let KakaoSDKUser = TargetDependency.external(name: "KakaoSDKUser")
    static let NaverThirdPartyLogin = TargetDependency.external(name: "NaverThirdPartyLogin")
}
