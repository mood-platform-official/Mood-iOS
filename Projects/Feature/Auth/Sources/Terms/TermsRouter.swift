import LinkNavigator
import SwiftUI
import Entity
import ThirdPartyLibrary
import Base

public struct TermsRouteBuilder<RootNavigator: RootNavigatorType> {
    public static func generate() -> RouteBuilderOf<RootNavigator> {
        var matchPath: String { Screen.Path.Terms.rawValue }
        return .init(matchPath: matchPath) { navigator, item, _ -> RouteViewController? in
            let query: RegisterInfo? = item.decoded()
            let intent = TermsIntent(
                initialState: .init(registerInfo: query), navigator: navigator
            )
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
