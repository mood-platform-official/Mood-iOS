import Foundation

public struct RegisterInfo: Equatable,Codable {
    public var oauthToken: String
    public var idToken: String
    
    public init(oauthToken: String, idToken: String) {
        self.oauthToken = oauthToken
        self.idToken = idToken
    }
}
