import Foundation

public extension UserDTO.EmailExist {
    struct Request: Encodable {
        public let email: String
    }
}
