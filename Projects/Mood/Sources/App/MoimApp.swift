import SwiftUI
import LinkNavigator
import Entity
import DesignSystem
import KakaoSDKCommon
import KakaoSDKAuth
import NaverThirdPartyLogin
import Base

@main
struct MoimApp: App {
    var navigator: SingleLinkNavigator = .init(
        routeBuilderItemList: AppRouterGroup().routers,
        dependency: AppDependency()
    )
    
    init() {
        DesignSystemFontFamily.registerAllCustomFonts()
        KakaoSDK.initSDK(appKey: Env.KAKAO_APP_KEY)
        initNaver()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView {
                LinkNavigationView(
                    linkNavigator: navigator,
                    item: .init(path: Screen.Path.Auth.rawValue)
                )
            }
            .ignoresSafeArea(.all)
            .onOpenURL { url in
                if (AuthApi.isKakaoTalkLoginUrl(url)) {
                    _ = AuthController.handleOpenUrl(url: url)
                }
                
                NaverThirdPartyLoginConnection
                    .getSharedInstance()
                    .receiveAccessToken(url)
            }
        }
    }
    
    private func initNaver() {
        let instance = NaverThirdPartyLoginConnection.getSharedInstance()
        // 네이버 앱으로 로그인 허용
        instance?.isNaverAppOauthEnable = true
        // 브라우저 로그인 허용
        instance?.isInAppOauthEnable = true
        
        // 네이버 로그인 세로모드 고정
        instance?.setOnlyPortraitSupportInIphone(true)
        
        // NaverThirdPartyConstantsForApp.h에 선언한 상수 등록
        instance?.serviceUrlScheme = "com.mood.Mood"
        instance?.consumerKey = Env.NAVER_CLIENT_ID
        instance?.consumerSecret = Env.NAVER_CLIENT_SECRET
        instance?.appName = "Mood"
    }
}
