import Foundation
import Alamofire

final class APIInterceptor: RequestAdapter, RequestRetrier {
    func adapt(_ urlRequest: URLRequest, for session: Alamofire.Session, completion: @escaping (Result<URLRequest, any Error>) -> Void) {
        var request = urlRequest
        guard let token = UserDefaults.value(forKey: "token") as? String else { // Get token
            completion(.success(request))
            return
        }
        
        request.headers.add(.authorization(bearerToken: token))
        
        if let tokenHeader = request.headers.first(where: { $0 == .authorization(bearerToken: token) }) {
            print("\nadapted; token added to the header field is: \(tokenHeader)\n")
        }
        
        completion(.success(request))
    }
    
    func retry(_ request: Alamofire.Request, for session: Alamofire.Session, dueTo error: any Error, completion: @escaping (Alamofire.RetryResult) -> Void) {
        let retryLimit = 3
        guard request.retryCount < retryLimit else {
            completion(.doNotRetry)
            return
        }
        print("\nretried; retry count: \(request.retryCount)\n")
        
        Task {
            let getRefreshToken = await self.refreshToken()
            getRefreshToken ? completion(.retry) : completion(.doNotRetry)
        }
    }
}

extension APIInterceptor {
    func refreshToken() async -> Bool {
        // TODO: RefreshToken API 호출
//        let result = try? await APIClient().request(Common.Endpoint.refreshToken, decode: Common.Response).serializingData().response
        
        // TODO: Save RefreshToken to (UserDefaults)
        
        
//        return result == true
        return true
    }
}
