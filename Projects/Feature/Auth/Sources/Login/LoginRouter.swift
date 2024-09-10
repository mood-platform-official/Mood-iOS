import LinkNavigator
import SwiftUI
import Entity
import ThirdPartyLibrary
import Base

public struct LoginRouteBuilder<RootNavigator: RootNavigatorType> {
    public static func generate() -> RouteBuilderOf<RootNavigator> {
        var matchPath: String { Screen.Path.Login.rawValue }
        return .init(matchPath: matchPath) { navigator, _, _ -> RouteViewController? in
            let intent = LoginIntent(initialState: .init(), navigator: navigator)
            let viewController = DebugWrappingViewController(matchPath: matchPath) {
                LoginView(container: .init(
                    intent: intent,
                    state: intent.state,
                    modelChangePublisher: intent.objectWillChange
                ))
            }
            return viewController
        }
    }
}
