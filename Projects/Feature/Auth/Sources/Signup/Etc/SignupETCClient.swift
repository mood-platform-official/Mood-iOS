import Dependencies

struct SignupETCClient {
    var checkDuplNickname: @Sendable (String) async throws -> Bool
}

//extension AuthClient: DependencyKey {
//    static var liveValue = AuthClient(
//        checkDuplEmail: { email in
//            return
//        }
//    )
//}

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
