import Dependencies

struct AuthClient {
    
}

extension AuthClient: DependencyKey {
    static var liveValue = AuthClient()
}

extension DependencyValues {
    var authClient: AuthClient {
        get { self[AuthClient.self] }
        set { self[AuthClient.self] = newValue }
    }
}
