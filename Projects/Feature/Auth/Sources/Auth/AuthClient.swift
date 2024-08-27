import Dependencies

struct AuthClient {
    var checkDuplEmail: @Sendable (String) async throws -> Bool
}

//extension AuthClient: DependencyKey {
//    static var liveValue = AuthClient(
//        checkDuplEmail: { email in
//            return
//        }
//    )
//}

extension AuthClient: TestDependencyKey {
    static var testValue: AuthClient = .init(
        checkDuplEmail: { email in
            return email == "chicazic@gmail.com"
        }
    )
}

extension DependencyValues {
    var authClient: AuthClient {
        get { self[AuthClient.self] }
        set { self[AuthClient.self] = newValue }
    }
}
