import LinkNavigator
import SwiftUI
import Entity
import ThirdPartyLibrary
import Base

public struct HomeRouteBuilder<RootNavigator: RootNavigatorType> {
    public static func generate() -> RouteBuilderOf<RootNavigator> {
        var matchPath: String { Screen.Path.Home.rawValue }
        return .init(matchPath: matchPath) { navigator, _, _ -> RouteViewController? in
            let intent = HomeIntent(initialState: .init(), navigator: navigator)
            let viewcontroller = DebugWrappingViewController(matchPath: matchPath) {
                HomeView(container: .init(
                    intent: intent,
                    state: intent.state,
                    modelChangePublisher: intent.objectWillChange
                ))
            }
            return viewcontroller
        }
    }
}
