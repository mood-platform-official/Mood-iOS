import Foundation

public struct UserData {
    public var id: Int64?
    public var imageURL: String?
    public var name: String?
    public var nickname: String?
    public var email: String?
    public var birthDay: String?
    public var gender: String?
    public var phoneNumber: String?
    public var ageRange: String?
    
    public init(id: Int64?, imageURL: String? = nil, name: String? = nil, nickname: String? = nil, email: String? = nil, birthDay: String? = nil, gender: String? = nil, phoneNumber: String? = nil) {
        self.id = id
        self.imageURL = imageURL
        self.name = name
        self.nickname = nickname
        self.email = email
        self.birthDay = birthDay
        self.gender = gender
        self.phoneNumber = phoneNumber
    }
}
