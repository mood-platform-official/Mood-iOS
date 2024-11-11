import Dependencies
import Entity

public struct UserClient {
    public var usersCheck: @Sendable (_ nickname: String) async throws -> CommonDTO.Response
}

extension UserClient: DependencyKey {
    static public var liveValue: UserClient = .init(
        usersCheck: { nickname in
            let endPoint = UserEndPoint.usersCheck(nickname: nickname)
            return try await APIClient.shared.request(endPoint, decode: CommonDTO.Response.self)
        }
    )
}

extension DependencyValues {
    public var userClient: UserClient {
        get { self[UserClient.self] }
        set { self[UserClient.self] = newValue }
    }
}
