import LinkNavigator
import SwiftUI
import Entity
import ThirdPartyLibrary
import Base

public struct SignupETCRouter<RootNavigator: RootNavigatorType> {
    public static func generate() -> RouteBuilderOf<RootNavigator> {
        var matchPath: String { Screen.Path.SignupETC.rawValue }
        return .init(matchPath: matchPath) { navigator, _, _ -> RouteViewController? in
            let intent = SignupETCIntent(initialState: .init(), navigator: navigator)
            let viewController = DebugWrappingViewController(matchPath: matchPath) {
                SignupETCView(container: .init(
                    intent: intent,
                    state: intent.state,
                    modelChangePublisher: intent.objectWillChange
                ))
            }
            return viewController
        }
    }
}
