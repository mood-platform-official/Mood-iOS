import Foundation
import Combine
import Base
import LinkNavigator
import CoreKit
import Entity

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
            state.pwBottomText = state.password.isEmpty ? state.pwBottomText : ""
        case .changePasswordAgain(let pwAgain):
            state.passwordAgain = pwAgain ?? ""
            state.pwAgainBottomText = state.passwordAgain.isEmpty ? state.pwAgainBottomText : ""
        case .nextBtnDidTap:
            self.nextBtnDidTap()
        }
    }
}

// MARK: Custom Method

extension SignupPasswordIntent {
    private func viewOnAppear() {
        
    }
    
    private func nextBtnDidTap() {
        guard state.password.isValidPassword() else {
            state.pwBottomText = "영문 대소문자, 숫자, 특수문자 포함 8자 이상"
            state.pwAgainBottomText = "비밀번호가 일치하지 않습니다."
            return
        }
        
        guard state.password == state.passwordAgain else {
            state.pwAgainBottomText = "비밀번호가 일치하지 않습니다."
            return
        }
        
        navigator.next(linkItem: .init(path: Screen.Path.SignupETC.rawValue), isAnimated: true)
    }
}
