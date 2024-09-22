import Entity
import Foundation
import Alamofire

public enum UserEndPoint {
    case emailExist(UserDTO.EmailExist.Request)
    case nicknameExist(UserDTO.NicknameExist.Request)
}

extension UserEndPoint: Endpoint {
    public var method: Alamofire.HTTPMethod {
        switch self {
        case .emailExist: .get
        case .nicknameExist: .get
        }
    }
    
    public var path: String {
        switch self {
        case .emailExist: "/api/v1/users/email:exist"
        case .nicknameExist: "/api/v1/users/nickname:exist"
        }
    }
    
    public var queryItems: [URLQueryItem]? {
        switch self {
        case .emailExist(let query): [.init(name: "email", value: query.email)]
        case .nicknameExist(let query): [.init(name: "nickname", value: query.nickname)]
        }
    }
    
    public var headers: Alamofire.HTTPHeaders? {
        switch self {
        case .emailExist: nil
        case .nicknameExist: nil
        }
    }
    
    public var body: Alamofire.Parameters? {
        switch self {
        case .emailExist: nil
        case .nicknameExist: nil
        }
    }
    
    public var token: String? { nil }
    
    public var multipart: Alamofire.MultipartFormData? { nil }
    
    public func asURLRequest() throws -> URLRequest {
        let url = URL(string: baseURL + path)!
        var request = URLRequest(url: url)
        request.headers = headers ?? .default
        request.method = method
        
        return request
    }
}
