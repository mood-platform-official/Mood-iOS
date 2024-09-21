import Entity
import Foundation
import Alamofire

public enum AuthEndPoint {
    case native(AuthDTO.Native.Request)
    case nativeLogin(AuthDTO.NativeLogin.Request)
    case oauth(AuthDTO.OAuth.Request)
    case refreshToken
}

extension AuthEndPoint: Endpoint {
    public var method: Alamofire.HTTPMethod {
        switch self {
        case .native: .post
        case .nativeLogin: .post
        case .oauth: .post
        case .refreshToken: .post
        }
    }
    
    public var path: String {
        switch self {
        case .native: "/api/v1/auth/native"
        case .nativeLogin: "/api/v1/auth/native:login"
        case .oauth: "/api/v1/auth/oauth"
        case .refreshToken: "/api/v1/auth/tokens:refresh"
        }
    }
    
    public var queryItems: [URLQueryItem]? {
        switch self {
        case .native: nil
        case .nativeLogin: nil
        case .oauth(let query): [.init(name: "provider", value: query.provider)]
        case .refreshToken: nil
        }
    }
    
    public var headers: Alamofire.HTTPHeaders? {
        switch self {
        case .native: nil
        case .nativeLogin: nil
        case .oauth: nil
        case .refreshToken: [.init(name: "Authorization", value: "")]
        }
    }
    
    public var body: Alamofire.Parameters? {
        switch self {
        case .native(let param): [ "email": param.email,
                                   "password": param.password,
                                   "name": param.name,
                                   "nickname": param.nickname,
                                   "birth": param.birth,
                                   "gender": param.gender,
                                   "profileImagePath": param.profileImagePath,
                                   "phoneNumber": param.phoneNumber,
                                   "device": param.device]
        case .nativeLogin(let param): ["email": param.email,
                                       "password": param.password]
        case .oauth(let param): ["idToken": param.idToken,
                                 "nickname": param.nickname,
                                 "device": param.device]
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
        
        return request
    }
}
