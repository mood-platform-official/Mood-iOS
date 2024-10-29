import Foundation
import Combine
import Base
import LinkNavigator
import CoreKit
import Entity
import Dependencies
import NetworkKit
import Logger

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

    @Dependency(\.authClient) var authClient
    @Dependency(\.kakaoClient) var kakaoClient
    @Dependency(\.userClient) var userClient
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
        case .kakaoBtnDidTap:
            self.kakaoBtnDidTap()
        case .naverBtnDidTap:
            self.naverBtnDidTap()
        case .appleBtnDidTap:
            self.appleBtnDidTap()

        }
    }
}

// MARK: Custom Method

extension AuthIntent {
    private func viewOnAppear() {
        self.naverClient.delegate = self
    }

    private func kakaoBtnDidTap() {
        self.kakaoTask?.cancel()

        self.kakaoTask = Task { @MainActor in
            guard !(self.kakaoTask?.isCancelled ?? false) else { return }

            await self.kakaoLoginRequest()
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

    private func kakaoLoginRequest() async {
        do {
            let (accessToken, idToken) = try await self.kakaoClient.login()
            let param: AuthDTO.Login.Request = .init(
                provider: "KAKAO",
                oauthToken: accessToken,
                oidcToken: idToken
            )
            self.state.accessToken = accessToken
            self.state.idToken = idToken
            let login = try await self.authClient.login(param)
        } catch let error as APIError {
            Log.debug("API Error", [error.resultCode, error.message])
            if error.resultCode == APIError.LG0002 {
                await self.kakaoUserInfoRequest()
            }
        } catch {
            Log.debug("Fail Error Decode", error.localizedDescription)
        }
    }

    private func kakaoUserInfoRequest() async {
        do {
            let userData = try await self.kakaoClient.me()
            let param: AuthDTO.Register.Request = .init(
                provider: "KAKAO",
                email: userData.email ?? "",
                nickname: userData.nickname ?? "",
                name: userData.name ?? "",
                birth: userData.birthDay ?? "",
                gender: userData.gender ?? "",
                phoneNumber: userData.phoneNumber ?? "",
                socialIdToken: self.state.accessToken ?? "",
                oidcToken: self.state.idToken ?? ""
            )
            let register = try await self.authClient.register(param)
        } catch let error as APIError {
            Log.debug("API Error", [error.resultCode, error.message])
        } catch {
            Log.debug("Fail Error Decode", error.localizedDescription)
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
