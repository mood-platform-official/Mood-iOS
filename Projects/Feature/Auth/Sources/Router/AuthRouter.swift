import LinkNavigator
import SwiftUI
import Entity
import ThirdPartyLibrary

public typealias RootNavigatorType = LinkNavigatorFindLocationUsable & LinkNavigatorProtocol

public struct AuthRouteBuilder<RootNavigator: RootNavigatorType> {
    public static func generate() -> RouteBuilderOf<RootNavigator> {
        var matchPath: String { Screen.Path.Auth.rawValue }
        return .init(matchPath: matchPath) { navigator, _, _ -> RouteViewController? in
            let intent = AuthIntent(initialState: .init(), navigator: navigator)
            let vc = DebugWrappingViewController(matchPath: matchPath) {
                AuthView(container: .init(
                    intent: intent,
                    state: intent.state,
                    modelChangePublisher: intent.objectWillChange
                ))
                .navigationBarBackButtonHidden()
                .navigationTitle("")
            }
            return vc
        }
    }
}
