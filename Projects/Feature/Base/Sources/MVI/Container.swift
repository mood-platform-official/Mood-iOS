import Combine
import Foundation

public final class Container<Intent, State>: ObservableObject {
    
    // MARK: Lifecycle
    
    public init(
        intent: Intent,
        state: State,
        modelChangePublisher: ObjectWillChangePublisher)
    {
        self.intent = intent
        self.state = state
        
        modelChangePublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: objectWillChange.send)
            .store(in: &cancellable)
    }
    
    // MARK: Internal
    
    public let intent: Intent
    public let state: State
    
    // MARK: Private
    
    private var cancellable: Set<AnyCancellable> = []
    
}
