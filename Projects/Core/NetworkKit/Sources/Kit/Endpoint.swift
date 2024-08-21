import Foundation
import Alamofire
import Entity

public protocol Endpoint: URLRequestConvertible {
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
    var headers: HTTPHeaders? { get }
    var body: Parameters? { get }
    var token: String? { get }
    var multipart: MultipartFormData? { get }
}

extension Endpoint {
    // TODO: Common Endpoint property
    public var baseURL: String { Env.BASE_URL }
}
