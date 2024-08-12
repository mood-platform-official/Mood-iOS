import LinkNavigator
import SwiftUI

public struct AuthRouteBuilder: RouteBuilder {
    public var matchPath: String { "Auth" }
    
    public var build: (LinkNavigatorType, [String: String], DependencyType) -> MatchingViewController? {
        { navigator, items, dependency in
            let intent = AuthIntent(initialState: .init(), navigator: navigator)
            return WrappingController(matchPath: matchPath) {
                AuthView(container: .init(
                    intent: intent,
                    state: intent.state,
                    modelChangePublisher: intent.objectWillChange
                ))
            }
        }
    }
    
    public init() {}
}
