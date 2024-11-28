import Foundation

public extension AuthDTO.Login {
    struct Request: Encodable {
        public let provider: String
        public let oauthToken: String
        public let oidcToken: String
        
        public init(provider: String, oauthToken: String, oidcToken: String) {
            self.provider = provider
            self.oauthToken = oauthToken
            self.oidcToken = oidcToken
        }
    }
    
    struct Response: Decodable {
        public let accessToken: String?
        public let refreshToken: String?
    }
}
