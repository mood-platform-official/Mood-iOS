import Foundation
import Combine
import Base
import LinkNavigator
import Entity

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
        case .sendAuthCodeBtnDidTap:
            state.isShowAuthCodeField = !state.phoneNumber.isEmpty
            state.authCode = ""
            state.isEnabledAuthCodeField = true
        case .validAuthCodeBtnDidTap:
            state.isEnabledAuthCodeField = false
        case .nextBtnDidTap:
            navigator.next(linkItem: .init(path: Screen.Path.SignupTerms.rawValue), isAnimated: true)
        }
    }
}

// MARK: Custom Method

extension SignupPhoneAuthIntent {
    private func viewOnAppear() {
        
    }
}
