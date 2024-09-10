import LinkNavigator
import SwiftUI
import Entity
import ThirdPartyLibrary
import Base

public struct AuthRouteBuilder<RootNavigator: RootNavigatorType> {
    public static func generate() -> RouteBuilderOf<RootNavigator> {
        var matchPath: String { Screen.Path.Auth.rawValue }
        return .init(matchPath: matchPath) { navigator, _, _ -> RouteViewController? in
            let intent = AuthIntent(initialState: .init(), navigator: navigator)
            let viewcontroller = DebugWrappingViewController(matchPath: matchPath) {
                AuthView(container: .init(
                    intent: intent,
                    state: intent.state,
                    modelChangePublisher: intent.objectWillChange
                ))
            }
            return viewcontroller
        }
    }
}
