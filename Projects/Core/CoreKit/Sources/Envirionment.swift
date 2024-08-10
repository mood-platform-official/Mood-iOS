import Foundation

public enum Environment {
    // MARK: - Keys
    enum Keys {
        enum Plist {
            static let KAKAO_APP_KEY = "KAKAO_APP_KEY"
        }
    }

    // MARK: - Plist
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }()

    // MARK: - Plist values
    public static let KAKAO_APP_KEY: String = {
        guard let kakaoAppKey = Environment.infoDictionary[Keys.Plist.KAKAO_APP_KEY] as? String else {
            fatalError("Root URL not set in plist for this environment")
        }
        return kakaoAppKey
    }()
}
