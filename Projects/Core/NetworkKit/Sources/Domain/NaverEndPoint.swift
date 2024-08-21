import Entity
import Foundation
import Alamofire

public struct NaverEndPoint: Endpoint {
    public var method: Alamofire.HTTPMethod = .get
    
    public var path: String = "/v1/nid/me"
    
    public var queryItems: [URLQueryItem]?
    
    public var headers: Alamofire.HTTPHeaders?
    
    public var body: Alamofire.Parameters?
    
    public var token: String?
    
    public var multipart: Alamofire.MultipartFormData?
    
    public func asURLRequest() throws -> URLRequest {
        let url = URL(string: baseURL + path)!
        var request = URLRequest(url: url)
        request.headers = headers ?? .default
        request.method = method
        
        return request
    }
    
    public var baseURL: String = "https://openapi.naver.com"
    
    public init(headers: Alamofire.HTTPHeaders? = nil) {
        self.headers = headers
    }
}

public enum NaverLogin {
    
    public struct Success: Codable {
        public let id, name, nickname, email: String
        public let mobile, birthday, birthyear: String
        public let profile_image: String
        public let gender: String
    }
    
    public struct Response: Codable {
        public let result: String
        public let success: Success?
        
        enum CodingKeys: String, CodingKey {
            case result = "resultcode"
            case success = "response"
        }
        
        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            result = try container.decodeIfPresent(String.self, forKey: .result) ?? ""
            success = try container.decodeIfPresent(Success.self, forKey: .success)
        }
    }
}
