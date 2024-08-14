import Foundation
import Combine
import Base
import LinkNavigator
import CoreKit
import Entity

protocol AuthIntentType {
    var state: AuthModel.State { get }
    var navigator: RootNavigatorType { get }
    
    func send(action: AuthModel.ViewAction)
}

// MARK: AuthIntent

final class AuthIntent: ObservableObject, AuthIntentType {
    
    // MARK: Internal
    typealias State = AuthModel.State
    typealias ViewAction = AuthModel.ViewAction
    
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

extension AuthIntent: IntentType {
    
    func mutate(action: AuthModel.ViewAction, viewEffect: (() -> Void)?) {
        switch action {
        case .onAppear:
            self.viewOnAppear()
        case .changeEmail(let email):
            state.email = email ?? ""
            state.isDisabledEmailBtn = !(!state.email.isEmpty && state.email.isValidEmail())
            state.bottomText = state.isDisabledEmailBtn ? "올바른 이메일 형식으로 입력해주세요." : ""
        case .emailBtnDidTap:
            guard !state.isDisabledEmailBtn else { return }
            navigator.send(item: .init(path: Screen.Path.Auth.rawValue))
        }
    }
}

extension AuthIntent {
    private func viewOnAppear() {
        
    }
}

