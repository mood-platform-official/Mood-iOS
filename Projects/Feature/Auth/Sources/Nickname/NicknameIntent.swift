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

    @Dependency(\.userClient) var userClient

    @Published var state: State

    var cancellable: Set<AnyCancellable> = []

    var nicknameCheckTask: Task<Void, Error>?

    var navigator: RootNavigatorType

    init(
        initialState: State,
        navigator: RootNavigatorType
    ) {
        self.state = initialState
        self.navigator = navigator
    }

    deinit {
        nicknameCheckTask?.cancel()
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
        case .changeNickname(let nickname):
            Log.debug("Nickname changeNickname", nickname)
            state.nickname = nickname
            state.isError = false
            state.isEnabledNextBtn = !nickname.isEmpty
        case .nextBtnDidTap:
            Log.debug("Nickname nextBtnDidTap")
            nextBtnDidTap()
        }
    }
}

// MARK: Custom Method

extension NicknameIntent {
    private func nextBtnDidTap() {
        guard state.nickname.isValidNickname() else {
            state.isError = true
            state.isEnabledNextBtn = false
            return
        }
        self.nicknameCheckTask?.cancel()

        self.nicknameCheckTask = Task {
            guard !(nicknameCheckTask?.isCancelled ?? false) else { return }
            await self.nicknameCheckRequest()
        }
    }
}

// MARK: API

extension NicknameIntent {
    private func nicknameCheckRequest() async {
        do {
            let isDuplicated = try await userClient.usersCheck(state.nickname)
//            state.isError = isDuplicated
//            if isDuplicated {
//                navigator.send(item: .init(
//                    path: Screen.Path.Nickname.rawValue
//                ))
//            }
        } catch let error as APIError {
            Log.debug("API Error", [error.resultCode, error.message])
            state.isError = true
            state.isEnabledNextBtn = false
        } catch {
            Log.debug("Fail Error Decode", error.localizedDescription)
            state.isError = true
            state.isEnabledNextBtn = false
        }
    }
}
