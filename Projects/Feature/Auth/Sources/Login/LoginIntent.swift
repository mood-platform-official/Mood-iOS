import Foundation
import Combine
import Base
import LinkNavigator

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
        }
    }
}

// MARK: Custom Method

extension LoginIntent {
    private func viewOnAppear() {
        
    }
}
