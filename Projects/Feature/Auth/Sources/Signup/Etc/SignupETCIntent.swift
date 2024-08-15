import Foundation
import Combine
import Base
import LinkNavigator

protocol SignupETCIntentType {
    var state: SignupETCModel.State { get }
    
    func send(action: SignupETCModel.ViewAction)
}

// MARK: SignupETCIntent

final class SignupETCIntent: ObservableObject {
    
    // MARK: Internal
    
    typealias State = SignupETCModel.State
    typealias ViewAction = SignupETCModel.ViewAction
    
    @Published var state: State
    
    var cancellable: Set<AnyCancellable> = []

    init(
        initialState: State
    ) {
        self.state = initialState
    }
}

extension SignupETCIntent: IntentType, SignupETCIntentType {
    func mutate(action: SignupETCModel.ViewAction, viewEffect: (() -> Void)?) {
        switch action {
        case .onAppear:
            self.viewOnAppear()
        case .changeName(let name):
            state.name = name ?? ""
        case .changeBirthDay(let birthDay):
            state.birthDay = birthDay ?? ""
        case .changeNickname(let nickname):
            state.nickname = nickname ?? ""
        case .nextBtnDidTap:
            print("nextBtnDidTap")
        }
    }
}

// MARK: Custom Method

extension SignupETCIntent {
    private func viewOnAppear() {
        
    }
}
