import LinkNavigator
import SwiftUI
import Entity
import ThirdPartyLibrary
import Base

public struct NicknameRouteBuilder<RootNavigator: RootNavigatorType> {
    public static func generate() -> RouteBuilderOf<RootNavigator> {
        var matchPath: String { Screen.Path.Nickname.rawValue }
        return .init(matchPath: matchPath) { navigator, _, _ -> RouteViewController? in
            let intent = NicknameIntent(initialState: .init(), navigator: navigator)
            let viewcontroller = DebugWrappingViewController(matchPath: matchPath) {
                NicknameView(container: .init(
                    intent: intent,
                    state: intent.state,
                    modelChangePublisher: intent.objectWillChange
                ))
            }
            return viewcontroller
        }
    }
}
