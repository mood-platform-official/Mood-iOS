import Foundation

public struct UserData {
    var id: Int64?
    var imageURL: String?
    var name: String?
    var nickname: String?
    var email: String?
    var birthDay: String?
    var gender: String?
    var phoneNumber: String?
    var ageRange: String?
    
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
