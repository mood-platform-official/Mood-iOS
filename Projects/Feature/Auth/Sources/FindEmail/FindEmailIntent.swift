import Foundation
import Combine
import Base
import LinkNavigator
import Logger

protocol FindEmailIntentType {
    var state: FindEmailModel.State { get }
    var navigator: RootNavigatorType { get }

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
        case .changePhoneNumber(let phoneNumber):
            Log.debug("changePhoneNumber(phoneNumber)", phoneNumber ?? "")
            state.phoneNumber = phoneNumber ?? ""
            state.bottomText = state.phoneNumber.isEmpty ? state.bottomText : ""
        case .onSubmitPhoneNumber:
            Log.debug("onSubmitPhoneNumber")
            state.isEnabledFindEmailBtn = state.phoneNumber.isValidPhone()
        case .findEmailBtnDidTap:
            Log.debug("findEmailBtnDidTap")
            self.findEmailBtntDidTap()
        }
    }
}

// MARK: Custom Method

extension FindEmailIntent {
    private func viewOnAppear() {}

    private func findEmailBtntDidTap() {
        guard state.isEnabledFindEmailBtn else {
            Log.debug("\(#function) - invalidated PhoneNumber", state.phoneNumber)
            state.bottomText = "일치하는 사용자 정보를 찾을 수 없습니다."
            return
        }

    }
}
