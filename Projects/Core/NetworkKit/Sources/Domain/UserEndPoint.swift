import Entity
import Foundation
import Alamofire

public enum UserEndPoint {
    case usersCheck(nickname: String)
}

extension UserEndPoint: Endpoint {
    public var method: Alamofire.HTTPMethod {
        switch self {
        case .usersCheck: .get
        }
    }
    
    public var path: String {
        switch self {
        case .usersCheck: "/api/v1/users/check"
        }
    }
    
    public var queryItems: [URLQueryItem]? {
        switch self {
        case .usersCheck(let nickname): [.init(name: "nickname", value: nickname)]
        }
    }
    
    public var headers: Alamofire.HTTPHeaders? {
        switch self {
        case .usersCheck: nil
        }
    }
    
    public var body: Alamofire.Parameters? {
        switch self {
        case .usersCheck: nil
        }
    }
    
    public var token: String? { nil }
    
    public var multipart: Alamofire.MultipartFormData? { nil }
}
