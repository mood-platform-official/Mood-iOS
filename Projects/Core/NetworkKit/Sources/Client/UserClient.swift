import Dependencies
import Entity

public struct UserClient {
    public var emailExist: @Sendable (UserDTO.EmailExist.Request) async throws -> Bool
    public var nicknameExist: @Sendable (UserDTO.NicknameExist.Request) async throws -> Bool
}

extension UserClient: DependencyKey {
    static public var liveValue: UserClient = .init(
        emailExist: { request in
            let endPoint = UserEndPoint.emailExist(request)
            return try await APIClient.shared.request(endPoint, decode: Bool.self)
        },
        nicknameExist: { request in
            let endPoint = UserEndPoint.nicknameExist(request)
            return try await APIClient.shared.request(endPoint, decode: Bool.self)
        }
    )
}

extension DependencyValues {
    public var userClient: UserClient {
        get { self[UserClient.self] }
        set { self[UserClient.self] = newValue }
    }
}
