import SwiftUI
import LinkNavigator
import Entity
import DesignSystem

@main
struct MoimApp: App {
    var navigator: SingleLinkNavigator = .init(
        routeBuilderItemList: AppRouterGroup().routers,
        dependency: AppDependency()
    )
    
    init() {
        DesignSystemFontFamily.registerAllCustomFonts()
    }
    
    var body: some Scene {
        WindowGroup {
            LinkNavigationView(
                linkNavigator: navigator,
                item: .init(path: Screen.Path.Auth.rawValue)
            )
            .ignoresSafeArea(.all)
            .onOpenURL { url in
                
            }
        }
    }
}
