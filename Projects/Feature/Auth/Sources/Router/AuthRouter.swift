import LinkNavigator
import SwiftUI
import Entity

public struct AuthRouteBuilder: RouteBuilder {
    public var matchPath: String { Screen.Path.Auth.rawValue }
    
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
