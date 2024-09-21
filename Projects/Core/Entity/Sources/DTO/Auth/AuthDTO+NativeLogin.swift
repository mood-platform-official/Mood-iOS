import Foundation

public extension AuthDTO.NativeLogin {
    struct Request: Encodable {
        public let email: String
        public let password: String
    }
    
    struct Response: Decodable {
        public let passwordExpiration: Bool
        public let accessToken: String
        public let refreshToken: String
    }
}
