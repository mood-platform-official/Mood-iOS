import Foundation
import Combine
import Base
import LinkNavigator
import Entity
import Logger

protocol LoginIntentType {
    var state: LoginModel.State { get }
    var navigator: RootNavigatorType { get }

    func send(action: LoginModel.ViewAction)
}

// MARK: LoginIntent

final class LoginIntent: ObservableObject {

    // MARK: Internal

    typealias State = LoginModel.State
    typealias ViewAction = LoginModel.ViewAction

    @Published var state: State

    var cancellable: Set<AnyCancellable> = []
    var navigator: RootNavigatorType

    init(
        initialState: State,
        navigator: RootNavigatorType
    ) {
        self.state = initialState
        self.navigator = navigator
    }
}

extension LoginIntent: IntentType, LoginIntentType {
    func mutate(action: LoginModel.ViewAction, viewEffect: (() -> Void)?) {
        switch action {
        case .onAppear:
            self.viewOnAppear()
        case .changePassword(let password):
            Log.debug("changePassword(password)", password ?? "")
            state.password = password ?? ""
            state.isDisabledLoginBtn = state.password.isEmpty
        case .loginBtnDidTap:
            Log.debug("loginBtnDidTap")
            navigator.next(linkItem: .init(path: Screen.Path.SignupPassword.rawValue), isAnimated: true)
        case .findPWBtnDidTap:
            Log.debug("findPWBtnDidTap")
            navigator.next(linkItem: .init(path: Screen.Path.FindPassword.rawValue), isAnimated: true)
        }
    }
}

// MARK: Custom Method

extension LoginIntent {
    private func viewOnAppear() {}
}
