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
    var navigator: LinkNavigator {
        LinkNavigator(dependency: AppDependency(), builders: [AuthRouteBuilder()])
    }
    init() {
        KakaoSDK.initSDK(appKey: Environment.KAKAO_APP_KEY)
        DesignSystemFontFamily.registerAllCustomFonts()
    }
    
    var body: some Scene {
        WindowGroup {
            navigator.launch(paths: [Screen.Path.Auth.rawValue], items: [:])
        }
    }
}
