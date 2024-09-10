import Dependencies

struct SignupETCClient {
    var checkDuplNickname: @Sendable (String) async throws -> Bool
}

extension SignupETCClient: DependencyKey {
    static var liveValue = SignupETCClient(
        checkDuplNickname: { _ in
            return false
        }
    )
}

extension SignupETCClient: TestDependencyKey {
    static var testValue: SignupETCClient = .init(
        checkDuplNickname: { nickname in
            return nickname == "우기"
        }
    )
}

extension DependencyValues {
    var signupETCClient: SignupETCClient {
        get { self[SignupETCClient.self] }
        set { self[SignupETCClient.self] = newValue }
    }
}
