import Foundation

public extension AuthDTO.Native {
    struct Request: Encodable {
        public let email: String
        public let password: String
        public let name: String
        public let nickname: String
        public let birth: String
        public let gender: String
        public let profileImagePath: String
        public let phoneNumber: String
        public let device: String = "iOS"
    }
    
    struct Response: Decodable {
        public let nickname: String
        public let profileImageUrl: String
        public let role: String
    }
}
