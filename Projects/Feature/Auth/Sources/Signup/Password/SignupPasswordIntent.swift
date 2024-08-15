import Foundation
import Combine
import Base
import LinkNavigator

protocol SignupPasswordIntentType {
    var state: SignupPasswordModel.State { get }
    
    func send(action: SignupPasswordModel.ViewAction)
}

// MARK: SignupPasswordIntent

final class SignupPasswordIntent: ObservableObject {
    
    // MARK: Internal
    
    typealias State = SignupPasswordModel.State
    typealias ViewAction = SignupPasswordModel.ViewAction
    
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

extension SignupPasswordIntent: IntentType, SignupPasswordIntentType {
    func mutate(action: SignupPasswordModel.ViewAction, viewEffect: (() -> Void)?) {
        switch action {
        case .onAppear:
            self.viewOnAppear()
        case .changePassword(let pw):
            state.password = pw ?? ""
            let isValid = state.password.isValidPassword()
            && (state.password == state.passwordAgain)
            state.isDisabledNextBtn = isValid
        case .changePasswordAgain(let pwAgain):
            state.passwordAgain = pwAgain ?? ""
            let isValid = state.password.isValidPassword()
            && (state.password == state.passwordAgain)
            state.isDisabledNextBtn = isValid
        case .nextBtnDidTap:
            print("nextBtnDidTap")
        }
    }
}

// MARK: Custom Method

extension SignupPasswordIntent {
    private func viewOnAppear() {
        
    }
}
