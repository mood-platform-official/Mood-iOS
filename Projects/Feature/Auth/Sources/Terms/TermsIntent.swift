import Foundation
import Combine
import Base
import LinkNavigator
import CoreKit
import Entity
import Dependencies
import NetworkKit
import Logger

protocol TermsIntentType {
    var state: TermsModel.State { get }
    var navigator: RootNavigatorType { get }

    func send(action: TermsModel.ViewAction)
}

// MARK: TermsIntent

final class TermsIntent: ObservableObject, TermsIntentType {

    // MARK: Internal

    typealias State = TermsModel.State
    typealias ViewAction = TermsModel.ViewAction

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

    deinit {

    }
}

extension TermsIntent: IntentType {
    func mutate(action: TermsModel.ViewAction, viewEffect: (() -> Void)?) {
        switch action {
        case .onAppear:
            Log.debug("Terms onAppear")
        case .back:
            Log.debug("Terms back")

            self.navigator.back(isAnimated: true)
        }
    }
}
