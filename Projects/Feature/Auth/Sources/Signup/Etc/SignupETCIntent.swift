//
//  SignupETCIntent.swift
//  Auth
//
//  Created by 송형욱 on 8/15/24.
//  Copyright © 2024 com.mood. All rights reserved.
//

import Foundation
import Combine
import Dependencies

protocol SignupETCIntentType {
    var state: SignupETCModel.State { get }
    
    func send(action: SignupETCModel.ViewAction)
}

// MARK: SignupETCIntent

final class SignupETCIntent: ObservableObject {
    
    // MARK: Internal
    
    typealias State = SignupETCModel.State
    typealias ViewAction = SignupETCModel.ViewAction
    
    @Published var state: State
    
    var cancellable: Set<AnyCancellable> = []

    init(
        initialState: State
    ) {
        self.state = initialState
    }
}

extension SignupETCIntent: IntentType, SignupETCIntentType {
    func mutate(action: SignupETCModel.ViewAction, viewEffect: (() -> Void)?) {
        switch action {
        
        }
    }
}

// MARK: Custom Method

extension SignupETCIntent {
    
}
