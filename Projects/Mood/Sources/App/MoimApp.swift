import SwiftUI
import LinkNavigator

@main
struct MoimApp: App {
    var navigator: LinkNavigator {
        LinkNavigator(dependency: AppDependency(), builders: AppRouterGroup().routers)
    }
    
    var body: some Scene {
        WindowGroup {
            navigator
                .launch(paths: [], items: [:])
                .onOpenURL { url in
                    
                }
        }
    }
}
