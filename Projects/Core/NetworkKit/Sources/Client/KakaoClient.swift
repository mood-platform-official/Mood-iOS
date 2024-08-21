import Dependencies
import KakaoSDKUser
import KakaoSDKAuth
import KakaoSDKCommon
import Entity

public struct KakaoClient {
    public var login: @Sendable () async throws -> String
    public var me: @Sendable () async throws -> UserData
}

extension KakaoClient {
    private static func login() async throws -> String {
        return try await withCheckedThrowingContinuation { continuation in
            if UserApi.isKakaoTalkLoginAvailable() {
                UserApi.shared.loginWithKakaoTalk { oauthToken, error in
                    if let error {
                        continuation.resume(throwing: error)
                    }
                    if let oauthToken {
                        continuation.resume(returning: oauthToken.accessToken)
                    }
                }
            } else {
                UserApi.shared.loginWithKakaoAccount { oauthToken, error in
                    if let error {
                        continuation.resume(throwing: error)
                    }
                    if let oauthToken {
                        continuation.resume(returning: oauthToken.accessToken)
                    }
                }
            }
        }
    }
    
    private static func myInfo() async throws -> User {
        return try await withCheckedThrowingContinuation { continuation in
            UserApi.shared.me { user, error in
                if let error {
                    continuation.resume(throwing: error)
                }
                if let user {
                    continuation.resume(returning: user)
                }
            }
        }
    }
}

extension KakaoClient: DependencyKey {
    static public var liveValue: KakaoClient = .init(
        login: {
            return try await KakaoClient.login()
        },
        me: {
            let user: User = try await KakaoClient.myInfo()
            let birthYear = user.kakaoAccount?.birthyear ?? ""
            let birthDay = user.kakaoAccount?.birthday ?? ""
            return UserData(
                id: user.id,
                imageURL: user.kakaoAccount?.profile?.profileImageUrl?.absoluteString,
                name: user.kakaoAccount?.name,
                nickname: user.kakaoAccount?.profile?.nickname,
                email: user.kakaoAccount?.email,
                birthDay: birthYear + birthDay,
                gender: user.kakaoAccount?.gender?.rawValue,
                phoneNumber: user.kakaoAccount?.phoneNumber
            )
        }
    )
}

extension DependencyValues {
    public var kakaoClient: KakaoClient {
        get { self[KakaoClient.self] }
        set { self[KakaoClient.self] = newValue }
    }
}
