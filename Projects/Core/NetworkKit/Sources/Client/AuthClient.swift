import Dependencies
import KakaoSDKUser
import KakaoSDKAuth
import KakaoSDKCommon
import Entity

public struct AuthClient {
    public var login: @Sendable (AuthDTO.Login.Request) async throws -> AuthDTO.Login.Response
    public var register: @Sendable (AuthDTO.Register.Request) async throws -> AuthDTO.Register.Response
    public var refreshToken: @Sendable () async throws -> AuthDTO.Login.Response
}

extension AuthClient: DependencyKey {
    static public var liveValue: AuthClient = .init(
        login: { request in
            let endPoint = AuthEndPoint.login(request)
            return try await APIClient.shared.request(endPoint, decode: AuthDTO.Login.Response.self)
        },
        register: { request in
            let endPoint = AuthEndPoint.register(request)
            return try await APIClient.shared.request(endPoint, decode: AuthDTO.Register.Response.self)
        },
        refreshToken: {
            let endPoint = AuthEndPoint.refreshToken
            return try await APIClient.shared.request(endPoint, decode: AuthDTO.Login.Response.self)
        }
    )
}

extension DependencyValues {
    public var authClient: AuthClient {
        get { self[AuthClient.self] }
        set { self[AuthClient.self] = newValue }
    }
}
