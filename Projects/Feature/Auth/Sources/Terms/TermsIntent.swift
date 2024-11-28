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
        case .allSelected:
            Log.debug("Terms all selected")
            self.allAgreed()
        case .selectedRadio(let term):
            Log.debug("Terms selected Radio", term)
            self.selectedRadio(term)
        case .selectedArrow(let term):
            Log.debug("Terms selected arrow", term)
        }
    }
}

extension TermsIntent {
    func allAgreed() {
        self.state.isAllAgreed.toggle()

        self.state.isCorrectAgeSelected = self.state.isAllAgreed
        self.state.isPersonalSelected = self.state.isAllAgreed
        self.state.isServiceSelected = self.state.isAllAgreed
        self.state.isMarketingSelected = self.state.isAllAgreed
    }

    func selectedRadio(_ term: TermsModel.Term) {
        switch term {
        case .correctAge: self.state.isCorrectAgeSelected.toggle()
        case .personal: self.state.isPersonalSelected.toggle()
        case .service: self.state.isServiceSelected.toggle()
        case .marketing: self.state.isMarketingSelected.toggle()
        }
        self.state.isAllAgreed = self.state.isCorrectAgeSelected
        && self.state.isPersonalSelected
        && self.state.isServiceSelected
        && self.state.isMarketingSelected
    }
}
