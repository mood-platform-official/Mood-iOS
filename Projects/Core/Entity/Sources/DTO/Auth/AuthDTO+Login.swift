import Foundation

public extension AuthDTO.Login {
    struct Request: Encodable {
        public let provider: String
        public let oauthToken: String
        public let oidcToken: String
    }
    
    struct Response: Decodable {
        public let accessToken: String?
        public let refreshToken: String?
    }
}
