import SwiftUI
import Auth
import CoreKit
import KakaoSDKCommon
import KakaoSDKAuth
import LinkNavigator
import Entity
import DesignSystem

struct AppDependency: DependencyType { }

@main
struct AuthApp: App {
    var navigator: SingleLinkNavigator = .init(
        routeBuilderItemList: [
            AuthRouteBuilder.generate(),
            LoginRouteBuilder.generate()
        ],
        dependency: AppDependency()
    )
    init() {
        KakaoSDK.initSDK(appKey: Environment.KAKAO_APP_KEY)
        DesignSystemFontFamily.registerAllCustomFonts()
    }
    
    var body: some Scene {
        WindowGroup {
            LinkNavigationView(
                linkNavigator: navigator,
                item: .init(path: Screen.Path.Auth.rawValue)
            )
        }
    }
}
