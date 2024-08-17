import Foundation
import Combine
import Base
import LinkNavigator

protocol SignupPhoneAuthIntentType {
    var state: SignupPhoneAuthModel.State { get }
    
    func send(action: SignupPhoneAuthModel.ViewAction)
}

// MARK: SignupPhoneAuthIntent

final class SignupPhoneAuthIntent: ObservableObject {
    
    // MARK: Internal
    
    typealias State = SignupPhoneAuthModel.State
    typealias ViewAction = SignupPhoneAuthModel.ViewAction
    
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

extension SignupPhoneAuthIntent: IntentType, SignupPhoneAuthIntentType {
    func mutate(action: SignupPhoneAuthModel.ViewAction, viewEffect: (() -> Void)?) {
        switch action {
        case .onAppear:
            self.viewOnAppear()
        case .changePhoneNumber(let phoneNumber):
            state.phoneNumber = phoneNumber ?? ""
        case .changeAuthCode(let authCode):
            state.authCode = authCode ?? ""
        case .authBtnDidTap:
            state.isShowAuthCodeField = !state.phoneNumber.isEmpty
        case .nextBtnDidTap:
            print("nextBtnDidTap")
        }
    }
}

// MARK: Custom Method

extension SignupPhoneAuthIntent {
    private func viewOnAppear() {
        
    }
}
