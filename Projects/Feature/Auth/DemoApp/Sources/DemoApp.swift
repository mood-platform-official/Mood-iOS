import SwiftUI
import Auth
import CoreKit
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct AuthApp: App {
    
    init() {
        KakaoSDK.initSDK(appKey: Environment.KAKAO_APP_KEY)
    }
    
    var body: some Scene {
        WindowGroup {
            AuthView()
        }
    }
}
