import Entity
import Foundation
import Alamofire

public enum AuthEndPoint {
    case login(AuthDTO.Login.Request)
    case register(AuthDTO.Register.Request)
    case refreshToken
}

extension AuthEndPoint: Endpoint {
    public var method: Alamofire.HTTPMethod {
        switch self {
        case .login, .register, .refreshToken: .post
        }
    }
    
    public var path: String {
        switch self {
        case .login(let param): "/api/v1/auth/oauth/\(param.provider):login"
        case .register(let param): "/api/v1/auth/oauth/\(param.provider):register"
        case .refreshToken: "/api/v1/auth/tokens:refresh"
        }
    }
    
    public var queryItems: [URLQueryItem]? {
        switch self {
        case .login, .register, .refreshToken: nil
        }
    }
    
    public var headers: Alamofire.HTTPHeaders? {
        switch self {
        case .login: .common()
        case .register: .common()
        case .refreshToken: [.init(name: "Authorization", value: "")]
        }
    }
    
    public var body: Alamofire.Parameters? {
        switch self {
        case .login(let param): [
            "oauthToken": param.oauthToken,
            "oidcToken": param.oidcToken
        ]
        case .register(let param): [
            "email": param.email,
            "nickname": param.nickname,
            "name": param.name,
            "birth": param.birth,
            "gender": param.gender,
            "phoneNumber": param.phoneNumber,
            "socialIdToken": param.socialIdToken,
            "oidcToken": param.oidcToken
        ]
        case .refreshToken: nil
        }
    }
    
    public var token: String? { nil }
    
    public var multipart: Alamofire.MultipartFormData? { nil }
    
    public func asURLRequest() throws -> URLRequest {
        let url = URL(string: baseURL + path)!
        var request = URLRequest(url: url)
        request.headers = headers ?? .default
        request.method = method
        if let body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        return request
    }
}
