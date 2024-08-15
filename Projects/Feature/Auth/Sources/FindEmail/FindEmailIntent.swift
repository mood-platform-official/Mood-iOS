import Foundation
import Combine
import Base
import LinkNavigator

protocol FindEmailIntentType {
    var state: FindEmailModel.State { get }
    
    func send(action: FindEmailModel.ViewAction)
}

// MARK: FindEmailIntent

final class FindEmailIntent: ObservableObject {
    
    // MARK: Internal
    
    typealias State = FindEmailModel.State
    typealias ViewAction = FindEmailModel.ViewAction
    
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

extension FindEmailIntent: IntentType, FindEmailIntentType {
    func mutate(action: FindEmailModel.ViewAction, viewEffect: (() -> Void)?) {
        switch action {
        case .onAppear:
            self.viewOnAppear()
        case .changePhoneNumber(let pn):
            state.phoneNumber = pn ?? ""
            state.isDisabledFindEmailBtn = state.phoneNumber.isValidPhone()
        case .findEmailBtnDidTap:
            print("findEmailBtnDidTap")
        }
    }
}

// MARK: Custom Method

extension FindEmailIntent {
    private func viewOnAppear() {
        
    }
}
