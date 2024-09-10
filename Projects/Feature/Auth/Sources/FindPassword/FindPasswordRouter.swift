import LinkNavigator
import SwiftUI
import Entity
import ThirdPartyLibrary
import Base

public struct FindPasswordRouter<RootNavigator: RootNavigatorType> {
    public static func generate() -> RouteBuilderOf<RootNavigator> {
        var matchPath: String { Screen.Path.FindPassword.rawValue }
        return .init(matchPath: matchPath) { navigator, _, _ -> RouteViewController? in
            let intent = FindPasswordIntent(initialState: .init(), navigator: navigator)
            let viewController = DebugWrappingViewController(matchPath: matchPath) {
                FindPasswordView(container: .init(
                    intent: intent,
                    state: intent.state,
                    modelChangePublisher: intent.objectWillChange
                ))
            }
            return viewController
        }
    }
}
