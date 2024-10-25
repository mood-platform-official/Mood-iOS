import Foundation

public extension UserDTO.EmailExist {
    struct Request: Encodable {
        public let email: String
        
        public init(email: String) {
            self.email = email
        }
    }
}
