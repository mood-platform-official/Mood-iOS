import SwiftUI
import LinkNavigator
import Entity
import DesignSystem
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct MoimApp: App {
    var navigator: SingleLinkNavigator = .init(
        routeBuilderItemList: AppRouterGroup().routers,
        dependency: AppDependency()
    )
    
    init() {
        DesignSystemFontFamily.registerAllCustomFonts()
        KakaoSDK.initSDK(appKey: Env.KAKAO_APP_KEY)
    }
    
    var body: some Scene {
        WindowGroup {
            LinkNavigationView(
                linkNavigator: navigator,
                item: .init(path: Screen.Path.Auth.rawValue)
            )
            .ignoresSafeArea(.all)
            .onOpenURL { url in
                if (AuthApi.isKakaoTalkLoginUrl(url)) {
                    _ = AuthController.handleOpenUrl(url: url)
                }
            }
        }
    }
}
