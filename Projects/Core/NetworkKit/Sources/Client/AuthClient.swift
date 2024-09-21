import Dependencies
import KakaoSDKUser
import KakaoSDKAuth
import KakaoSDKCommon
import Entity

public struct AuthClient {
    public var native: @Sendable (AuthDTO.Native.Request) async throws -> AuthDTO.Native.Response
    public var nativeLogin: @Sendable (AuthDTO.NativeLogin.Request) async throws -> AuthDTO.NativeLogin.Response
    public var oAuth: @Sendable (AuthDTO.OAuth.Request) async throws -> Void
//    public var refreshToken: @Sendable (AuthDTO..Request) async throws -> AuthDTO.OAuth.Response
}

extension AuthClient: DependencyKey {
    static public var liveValue: AuthClient = .init(
        native: { request in
            let endPoint = AuthEndPoint.native(request)
            return try await APIClient.shared.request(endPoint, decode: AuthDTO.Native.Response.self)
        },
        nativeLogin: { request in
            let endPoint = AuthEndPoint.nativeLogin(request)
            return try await APIClient.shared.request(endPoint, decode: AuthDTO.NativeLogin.Response.self)
        },
        oAuth: { request in
            let endPoint = AuthEndPoint.oauth(request)
            _ = try await APIClient.shared.request(endPoint, decode: CommonDTO.Response.self)
        }
    )
}

extension DependencyValues {
    public var authClient: AuthClient {
        get { self[AuthClient.self] }
        set { self[AuthClient.self] = newValue }
    }
}
