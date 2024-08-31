import Foundation
import Combine
import Base
import LinkNavigator
import Entity
import Logger

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
            Log.debug("changePhoneNumber", state.phoneNumber)
            state.phoneNumber = phoneNumber ?? ""
        case .changeAuthCode(let authCode):
            Log.debug("changeAuthCode", state.authCode)
            state.authCode = authCode ?? ""
        case .sendAuthCodeBtnDidTap:
            Log.debug("sendAuthCodeBtnDidTap")
            state.isShowAuthCodeField = !state.phoneNumber.isEmpty
            state.authCode = ""
            state.isEnabledAuthCodeField = true
        case .validAuthCodeBtnDidTap:
            Log.debug("validAuthCodeBtnDidTap")
            state.isEnabledAuthCodeField = false
        case .nextBtnDidTap:
            Log.debug("nextBtnDidTap")
            navigator.next(linkItem: .init(path: Screen.Path.SignupTerms.rawValue), isAnimated: true)
        }
    }
}

// MARK: Custom Method

extension SignupPhoneAuthIntent {
    private func viewOnAppear() {
        
    }
}
