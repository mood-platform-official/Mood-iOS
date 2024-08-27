import LinkNavigator
import SwiftUI
import Entity
import ThirdPartyLibrary
import Base

public struct SignupPhoneAuthRouter<RootNavigator: RootNavigatorType> {
    public static func generate() -> RouteBuilderOf<RootNavigator> {
        var matchPath: String { Screen.Path.SignupPhoneAuth.rawValue }
        return .init(matchPath: matchPath) { navigator, _, _ -> RouteViewController? in
            let intent = SignupPhoneAuthIntent(initialState: .init(), navigator: navigator)
            let vc = DebugWrappingViewController(matchPath: matchPath) {
                SignupPhoneAuthView(container: .init(
                    intent: intent,
                    state: intent.state,
                    modelChangePublisher: intent.objectWillChange
                ))
            }
            return vc
        }
    }
}
