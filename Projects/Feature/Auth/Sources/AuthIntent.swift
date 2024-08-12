import Foundation
import Combine
import Base
import LinkNavigator

protocol AuthIntentType {
    var state: AuthModel.State { get }
    var navigator: LinkNavigatorType { get }
    
    func send(action: AuthModel.ViewAction)
}

// MARK: AuthIntent

final class AuthIntent: ObservableObject, AuthIntentType {
    
    // MARK: Internal
    typealias State = AuthModel.State
    typealias ViewAction = AuthModel.ViewAction
    
    @Published var state: State
    
    var cancellable: Set<AnyCancellable> = []
    var navigator: LinkNavigatorType

    init(
        initialState: State,
        navigator: LinkNavigatorType
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
        case .changeError(let isError):
            state.isError = isError
        }
    }
}

extension AuthIntent {
    func viewOnAppear() {
        
    }
}

