import Combine
import Base
import LinkNavigator
import CoreKit
import Entity
import Dependencies
import NetworkKit
import Logger

protocol NicknameIntentType {
    var state: NicknameModel.State { get }
    var navigator: RootNavigatorType { get }
    
    func send(action: NicknameModel.ViewAction)
}

// MARK: NicknameIntent

final class NicknameIntent: ObservableObject, NicknameIntentType {
    
    // MARK: Internal
    
    typealias State = NicknameModel.State
    typealias ViewAction = NicknameModel.ViewAction
    
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

extension NicknameIntent: IntentType {
    func mutate(action: NicknameModel.ViewAction, viewEffect: (() -> Void)?) {
        switch action {
        case .onAppear:
            Log.debug("Nickname onAppear")
        case .back:
            Log.debug("Nickname back")
            self.navigator.back(isAnimated: true)
        }
    }
}

// MARK: Custom Method

extension NicknameIntent {

}
