import Foundation
import Combine

// MARK: - IntentType

public protocol IntentType: AnyObject {
    associatedtype ViewAction
    associatedtype State
    
    var state: State { get set }
    var cancellable: Set<AnyCancellable> { get set }
    
    func send(action: ViewAction)
    func send(action: ViewAction, viewEffect: (() -> Void)?)
    func mutate(action: ViewAction, viewEffect: (() -> Void)?)
}

extension IntentType {
    
    public func send(action: ViewAction) {
        mutate(action: action, viewEffect: .none)
    }
    
    public func send(action: ViewAction, viewEffect: (() -> Void)?) {
        mutate(action: action, viewEffect: viewEffect)
    }
}

// MARK: - IntentBindingType

public protocol IntentBindingType {
    associatedtype IntentType
    associatedtype State
    
    var container: Container<IntentType, State> { get }
    var intent: IntentType { get }
    var state: State { get }
}
