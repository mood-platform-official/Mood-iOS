import Alamofire
import UIKit
import Entity

extension Alamofire.HTTPHeaders {
    static func common() -> HTTPHeaders {
        let agent = "Mood/\(Env.BUNDLE_SHORT_VERSION) iOS/\(systemVersion)"
        return [
            .init(name: "Mood-Agent", value: agent),
            .init(name: "Device-Uuid", value: deviceUUID),
            .init(name: "Accept-Language", value: "ko"),
            .init(name: "content-type", value: "application/json")
        ]
    }
    
    private static var deviceUUID: String {
        UIDevice.current.identifierForVendor?.uuidString ?? ""
    }
    
    private static var systemVersion: String {
        UIDevice.current.systemVersion
    }
}
