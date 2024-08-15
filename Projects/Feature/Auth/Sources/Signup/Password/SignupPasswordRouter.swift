import LinkNavigator
import SwiftUI
import Entity
import ThirdPartyLibrary

public struct SignupPasswordRouter<RootNavigator: RootNavigatorType> {
    public static func generate() -> RouteBuilderOf<RootNavigator> {
        var matchPath: String { Screen.Path.SignupPassword.rawValue }
        return .init(matchPath: matchPath) { navigator, _, _ -> RouteViewController? in
            let intent = SignupPasswordIntent(initialState: .init(), navigator: navigator)
            let vc = DebugWrappingViewController(matchPath: matchPath) {
                SignupPasswordView(container: .init(
                    intent: intent,
                    state: intent.state,
                    modelChangePublisher: intent.objectWillChange
                ))
            }
            return vc
        }
    }
}
