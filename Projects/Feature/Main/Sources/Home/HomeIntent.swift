import Combine
import Dependencies
import Base

protocol HomeIntentType {
    var state: HomeModel.State { get }
    
    func send(action: HomeModel.ViewAction)
}

// MARK: HomeIntent

final class HomeIntent: ObservableObject {
    
    // MARK: Internal
    
    typealias State = HomeModel.State
    typealias ViewAction = HomeModel.ViewAction
    
    @Published var state: State
    
    var cancellable: Set<AnyCancellable> = []

    init(
        initialState: State
    ) {
        self.state = initialState
    }
}

extension HomeIntent: IntentType, HomeIntentType {
    func mutate(action: HomeModel.ViewAction, viewEffect: (() -> Void)?) {
        switch action {
        
        }
    }
}

// MARK: Custom Method

extension HomeIntent {
    
}
