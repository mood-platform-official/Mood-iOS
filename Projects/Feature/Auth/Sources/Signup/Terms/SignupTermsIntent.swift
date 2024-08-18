import Foundation
import Combine
import Base
import LinkNavigator

protocol SignupTermsIntentType {
    var state: SignupTermsModel.State { get }
    var navigator: RootNavigatorType { get }
    
    func send(action: SignupTermsModel.ViewAction)
}

// MARK: SignupTermsIntent

final class SignupTermsIntent: ObservableObject {
    
    // MARK: Internal
    
    typealias State = SignupTermsModel.State
    typealias ViewAction = SignupTermsModel.ViewAction
    
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

extension SignupTermsIntent: IntentType, SignupTermsIntentType {
    func mutate(action: SignupTermsModel.ViewAction, viewEffect: (() -> Void)?) {
        switch action {
        case .onAppear:
            self.viewOnAppear()
        case .serviceTermsBtnDidTap:
            break
        case .personalTermsBtnDidTap:
            break
        case .marketingTermsBtnDidTap:
            break
        case .nextBtnDidTap:
            break
        }
    }
}

// MARK: Custom Method

extension SignupTermsIntent {
    private func viewOnAppear() {
        
    }
}
