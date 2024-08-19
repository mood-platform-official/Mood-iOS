import SwiftUI
import Auth
import KakaoSDKCommon
import KakaoSDKAuth
import LinkNavigator
import Entity
import DesignSystem
import Base

@main
struct AuthApp: App {
    var navigator: SingleLinkNavigator = .init(
        routeBuilderItemList: AuthRouterGroup().routers,
        dependency: AuthDependency()
    )
    init() {
        KakaoSDK.initSDK(appKey: Env.KAKAO_APP_KEY)
        DesignSystemFontFamily.registerAllCustomFonts()
    }
    
    var body: some Scene {
        WindowGroup {
            LinkNavigationView(
                linkNavigator: navigator,
                item: .init(path: Screen.Path.Auth.rawValue)
            )
            .onOpenURL { url in
                if (AuthApi.isKakaoTalkLoginUrl(url)) {
                    _ = AuthController.handleOpenUrl(url: url)
                }
            }
        }
    }
}
