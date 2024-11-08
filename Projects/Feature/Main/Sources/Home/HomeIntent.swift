import Combine
import Dependencies
import Base
import Logger

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
    
    private var navigator: RootNavigatorType

    init(
        initialState: State,
        navigator: RootNavigatorType
    ) {
        self.state = initialState
        self.navigator = navigator
        
        Log.debug("HomeIntent init")
    }
    
    deinit {
        Log.debug("HomeIntent deinit")
    }
}

extension HomeIntent: IntentType, HomeIntentType {
    func mutate(action: HomeModel.ViewAction, viewEffect: (() -> Void)?) {
        switch action {
        case .onAppear:
            self.state.dayOfWeek = (1...8).map { HomeModel.DayOfWeek(day: "\($0)", dayOfWeek: "\($0)", isSelected: $0 == 1) }
        case .selectedDateCard(let dayOfWeek):
            Log.debug("selectedDateCard", dayOfWeek)
        }
    }
}

// MARK: Custom Method

extension HomeIntent {
    
}
