import Foundation
import Combine
import Base
import LinkNavigator
import Logger

protocol FindPasswordIntentType {
    var state: FindPasswordModel.State { get }
    
    func send(action: FindPasswordModel.ViewAction)
}

// MARK: FindPasswordIntent

final class FindPasswordIntent: ObservableObject {
    
    // MARK: Internal
    
    typealias State = FindPasswordModel.State
    typealias ViewAction = FindPasswordModel.ViewAction
    
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

extension FindPasswordIntent: IntentType, FindPasswordIntentType {
    func mutate(action: FindPasswordModel.ViewAction, viewEffect: (() -> Void)?) {
        switch action {
        case .onAppear:
            self.viewOnAppear()
        case .changePhoneNumber(let pn):
            Log.debug("changePhoneNumber(pn)", pn ?? "")
            state.phoneNumber = pn ?? ""
            let isValid = state.phoneNumber.isValidPhone() && state.email.isValidEmail()
            state.isDisabledAuthenticationNumberBtn = isValid
        case .changeEmail(let email):
            Log.debug("changeEmail(email)", email ?? "")
            state.phoneNumber = email ?? ""
            let isValid = state.phoneNumber.isValidPhone() && state.email.isValidEmail()
            state.isDisabledAuthenticationNumberBtn = isValid
        case .authenticationNumberBtnDidTap:
            Log.debug("authenticationNumberBtnDidTap")
            print("authenticationNumberBtnDidTap")
        }
    }
}

// MARK: Custom Method

extension FindPasswordIntent {
    private func viewOnAppear() {
        
    }
}
