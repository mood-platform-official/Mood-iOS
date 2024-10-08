import Foundation
import Combine
import Base
import LinkNavigator
import CoreKit
import Entity
import Dependencies
import NetworkKit

protocol AuthIntentType {
    var state: AuthModel.State { get }
    var navigator: RootNavigatorType { get }

    func send(action: AuthModel.ViewAction)
}

// MARK: AuthIntent

final class AuthIntent: ObservableObject, AuthIntentType {

    // MARK: Internal
    typealias State = AuthModel.State
    typealias ViewAction = AuthModel.ViewAction

    @Dependency(\.authClient) var client
    @Dependency(\.kakaoClient) var kakao
    let naverClient = NaverClient()
    let appleClient = AppleClient()

    @Published var state: State

    var cancellable: Set<AnyCancellable> = []

    var kakaoTask: Task<Void, Error>?
    var naverTask: Task<Void, Error>?
    var dupEmailTask: Task<Void, Error>?

    var navigator: RootNavigatorType

    init(
        initialState: State,
        navigator: RootNavigatorType
    ) {
        self.state = initialState
        self.navigator = navigator
    }

    deinit {
        self.kakaoTask?.cancel()
        self.dupEmailTask?.cancel()
        self.naverTask?.cancel()

        self.cancellable.removeAll()
    }
}

extension AuthIntent: IntentType {

    func mutate(action: AuthModel.ViewAction, viewEffect: (() -> Void)?) {
        switch action {
        case .onAppear:
            self.viewOnAppear()
        case .changeEmail(let email):
            state.email = email ?? ""
            state.bottomText = state.email.isEmpty ? state.bottomText : ""
        case .emailBtnDidTap:
            self.emailBtnDidTap()
        case .kakaoBtnDidTap:
            self.kakaoBtnDidTap()
        case .naverBtnDidTap:
            self.naverBtnDidTap()
        case .appleBtnDidTap:
            self.appleBtnDidTap()
        case .findEmailBtnDidTap:
            navigator.next(linkItem: .init(path: Screen.Path.FindEmail.rawValue), isAnimated: true)
        case .findPWBtnDidTap:
            navigator.next(linkItem: .init(path: Screen.Path.FindPassword.rawValue), isAnimated: true)

        }
    }
}

// MARK: Custom Method

extension AuthIntent {
    private func viewOnAppear() {
        self.naverClient.delegate = self
    }

    private func emailBtnDidTap() {
        guard state.email.isValidEmail() else {
            state.bottomText = "올바른 이메일 형식으로 입력해주세요."
            return
        }

        self.dupEmailTask?.cancel()

        self.dupEmailTask = Task {
            let isDuplicated = await self.checkDupEmailRequest()

            guard !(self.dupEmailTask?.isCancelled ?? false) else { return }
            let path = isDuplicated
            ? Screen.Path.Login.rawValue
            : Screen.Path.SignupPassword.rawValue

            await MainActor.run {
                navigator.next(linkItem: .init(path: path), isAnimated: true)
            }
        }
    }

    private func kakaoBtnDidTap() {
        self.kakaoTask?.cancel()

        self.kakaoTask = Task { @MainActor in
//            let oauthToken = await self.kakaoLoginRequest()

            guard !(self.kakaoTask?.isCancelled ?? false) else { return }
        }
    }

    private func naverBtnDidTap() {
        self.naverTask?.cancel()

        self.naverTask = Task { @MainActor in
            self.naverClient.login()
        }
    }

    private func appleBtnDidTap() {

    }
}

// MARK: API

extension AuthIntent: NaverDelegate, AppleDelegate {
    private func checkDupEmailRequest() async -> Bool {
        do {
            return try await self.client.checkDuplEmail(state.email)
        } catch {
            print("asdfd")
            return false
        }
    }

    private func kakaoLoginRequest() async -> String {
        do {
            return try await self.kakao.login()
        } catch {
            Toast.shared.present(title: "error kakao login")
            return ""
        }
    }

    func naverUserInfo(_ user: UserData) {
        print(user)
    }

    func performRequests(_ result: Result<String, NetworkKit.AppleError>) {
        switch result {
        case .success(let identityToken):
            print(identityToken)
        case .failure(let failure):
            self.appleFailureResonse(failure)
        }
    }

    private func appleFailureResonse(_ error: AppleError) {
        switch error {
        case .canceled:
            break
        case .error(let error):
            Toast.shared.present(title: error.localizedDescription)
        case .message(let msg):
            Toast.shared.present(title: msg)
        }
    }
}
