import Foundation

public extension AuthDTO.OAuth {
    struct Request: Encodable {
        public let provider: String
        
        public let idToken: String
        public let nickname: String
        public let device: String = "iOS"
    }
}
