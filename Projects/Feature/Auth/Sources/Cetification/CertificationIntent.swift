import Combine
import Base
import LinkNavigator
import CoreKit
import Entity
import Dependencies
import NetworkKit
import Logger

protocol CertificationIntentType {
    var state: CertificationModel.State { get }
    var navigator: RootNavigatorType { get }

    func send(action: CertificationModel.ViewAction)
}

// MARK: CertificationIntent

final class CertificationIntent: ObservableObject, CertificationIntentType {

    // MARK: Internal

    typealias State = CertificationModel.State
    typealias ViewAction = CertificationModel.ViewAction

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

extension CertificationIntent: IntentType {
    func mutate(action: CertificationModel.ViewAction, viewEffect: (() -> Void)?) {
        switch action {
        case .onAppear:
            Log.debug("CertificationIntent onAppear")
        case .back:
            Log.debug("CertificationIntent back")
            self.navigator.back(isAnimated: true)
        case .changePhoneNumber(let phoneNumber):
            Log.debug("CertificationIntent changePhoneNumber", phoneNumber)
            state.phone = phoneNumber
        case .authBtnDidTap:
            Log.debug("CertificationIntent authBtnDidTap")
        case .doneBtnDidTap:
            Log.debug("CertificationIntent doneBtnDidTap")
//            navigator.next(linkItem: .init(path: Screen.Path.), isAnimated: true)
        }
    }
}

// MARK: Custom Method

extension CertificationIntent {

}
