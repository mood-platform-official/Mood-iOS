import Foundation
import Combine
import Base
import LinkNavigator
import CoreKit
import Entity

protocol AuthIntentType {
    var state: AuthModel.State { get }
    var navigator: RootNavigatorType? { get }
    
    func send(action: AuthModel.ViewAction)
}

// MARK: AuthIntent

final class AuthIntent: ObservableObject, AuthIntentType {
    
    // MARK: Internal
    typealias State = AuthModel.State
    typealias ViewAction = AuthModel.ViewAction
    
    @Published var state: State
    
    var cancellable: Set<AnyCancellable> = []
    var navigator: RootNavigatorType?

    init(
        initialState: State
    ) {
        self.state = initialState
    }
}

extension AuthIntent: IntentType {
    
    func mutate(action: AuthModel.ViewAction, viewEffect: (() -> Void)?) {
        switch action {
        case .onAppear:
            self.viewOnAppear()
        case .changeEmail(let email):
            state.email = email ?? ""
        case .emailBtnDidTap:
            self.emailBtnDidTap()
        }
    }
}


// MARK: Custom Method

extension AuthIntent {
    private func viewOnAppear() {
        
    }
    
    private func emailBtnDidTap() {
        guard state.isEnabledEmailBtn else { return }
        
        navigator?.next(linkItem: .init(path: Screen.Path.Login.rawValue), isAnimated: true)
    }
}

// MARK: API

extension AuthIntent {
    
}
