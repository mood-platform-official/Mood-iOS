import LinkNavigator
import SwiftUI
import Entity
import ThirdPartyLibrary
import Base

public struct TermsRouteBuilder<RootNavigator: RootNavigatorType> {
    public static func generate() -> RouteBuilderOf<RootNavigator> {
        var matchPath: String { Screen.Path.Terms.rawValue }
        return .init(matchPath: matchPath) { navigator, _, _ -> RouteViewController? in
            let intent = TermsIntent(initialState: .init(), navigator: navigator)
            let viewcontroller = DebugWrappingViewController(matchPath: matchPath) {
                TermsView(container: .init(
                    intent: intent,
                    state: intent.state,
                    modelChangePublisher: intent.objectWillChange
                ))
            }
            return viewcontroller
        }
    }
}
