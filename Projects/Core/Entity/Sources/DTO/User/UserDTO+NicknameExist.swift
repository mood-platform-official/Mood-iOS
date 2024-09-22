import Foundation

public extension UserDTO.NicknameExist {
    struct Request: Encodable {
        public let nickname: String
    }
}
