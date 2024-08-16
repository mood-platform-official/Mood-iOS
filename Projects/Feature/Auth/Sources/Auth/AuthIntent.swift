import Foundation
import Combine
import Base
import LinkNavigator
import CoreKit
import Entity
import Dependencies

protocol AuthIntentType {
    var state: AuthModel.State { get }
    var navigator: RootNavigatorType? { get }
    
    func send(action: AuthModel.ViewAction)
}

// MARK: AuthIntent

final class AuthIntent: ObservableObject, AuthIntentType {
    
    // MARK: Internal
    typealias State = AuthModel.State
    typealias ViewAction = AuthModel.ViewAction
    
    @Dependency(\.authClient) var client
    
    @Published var state: State
    
    var cancellable: Set<AnyCancellable> = []
    var navigator: RootNavigatorType?

    init(
        initialState: State
    ) {
        self.state = initialState
    }
}

extension AuthIntent: IntentType {
    
    func mutate(action: AuthModel.ViewAction, viewEffect: (() -> Void)?) {
        switch action {
        case .onAppear:
            self.viewOnAppear()
        case .changeEmail(let email):
            state.email = email ?? ""
        case .emailBtnDidTap:
            self.emailBtnDidTap()
        }
    }
}


// MARK: Custom Method

extension AuthIntent {
    private func viewOnAppear() {
        
    }
    
    private func emailBtnDidTap() {
        guard state.isEnabledEmailBtn else {
            state.bottomText = "올바른 이메일 형식으로 입력해주세요."
            return
        }
        
        Task {
            let isDuplicated = await self.checkDupEmailRequest()
            let path = isDuplicated
            ? Screen.Path.Login.rawValue
            : Screen.Path.SignupPassword.rawValue
            
            navigator?.next(linkItem: .init(path: path), isAnimated: true)
        }
    }
}

// MARK: API

extension AuthIntent {
    private func checkDupEmailRequest() async -> Bool {
        do {
            return try await self.client.checkDuplEmail(state.email)
        } catch {
            print("asdfd")
            return false
        }
    }
}
