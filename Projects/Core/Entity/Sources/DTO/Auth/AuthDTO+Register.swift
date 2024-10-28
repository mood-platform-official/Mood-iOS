import Foundation

public extension AuthDTO.Register {
    struct Request: Encodable {
        public let provider: String
        
        public let email: String
        public let nickname: String
        public let name: String
        public let birth: String
        public let gender: String
        public let phoneNumber: String
        public let socialIdToken: String
        public let oidcToken: String
        
        public init(provider: String, email: String, nickname: String, name: String, birth: String, gender: String, phoneNumber: String, socialIdToken: String, oidcToken: String) {
            self.provider = provider
            self.email = email
            self.nickname = nickname
            self.name = name
            self.birth = birth
            self.gender = gender
            self.phoneNumber = phoneNumber
            self.socialIdToken = socialIdToken
            self.oidcToken = oidcToken
        }
    }
    
    struct Response: Decodable {
        public let nickname, profileImageURL, role, createdAt: String?
        public let updatedAt: String?
        
        enum CodingKeys: String, CodingKey {
            case nickname
            case profileImageURL = "profileImageUrl"
            case role, createdAt, updatedAt
        }
    }
}
