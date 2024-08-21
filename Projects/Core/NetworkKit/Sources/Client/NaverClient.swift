import Dependencies
import Entity
import NaverThirdPartyLogin

public protocol NaverDelegate {
    func naverUserInfo(_ user: UserData)
}

public final class NaverClient: NSObject {
    var instance: NaverThirdPartyLoginConnection?
    
    public var delegate: NaverDelegate?
    
    var userInfoTask: Task<Void, Error>?
    
    public init(instance: NaverThirdPartyLoginConnection? = NaverThirdPartyLoginConnection.getSharedInstance()) {
        self.instance = instance
    }
    
    public func login() {
        self.instance?.delegate = self
        self.instance?.resetToken()
        self.instance?.requestThirdPartyLogin()
    }
    
    func userInfo() async throws -> UserData? {
        guard let accessToken = await self.instance?.accessToken,
              let tokenType = await self.instance?.tokenType else { return nil }
        
        let endPoint = NaverEndPoint(headers: [
            "Authorization": "\(tokenType) \(accessToken)"
        ])
        let me = try await APIClient.shared.request(endPoint, decode: NaverLogin.Response.self)
        let id = Int64(me.success?.id ?? "")
        let birthyear = me.success?.birthyear ?? ""
        let birthday = me.success?.birthday ?? ""
        return .init(
            id: id,
            imageURL: me.success?.profile_image,
            name: me.success?.name,
            nickname: me.success?.nickname,
            email: me.success?.email,
            birthDay: birthyear + birthday,
            gender: me.success?.gender,
            phoneNumber: me.success?.mobile
        )
    }
}

extension NaverClient: NaverThirdPartyLoginConnectionDelegate {
    public func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        self.userInfoTask?.cancel()
        
        self.userInfoTask = Task { @MainActor in
            guard let user = try? await self.userInfo(),
                    let isCancel = self.userInfoTask?.isCancelled,
                    !isCancel else { return }
            
            self.delegate?.naverUserInfo(user)
        }
    }
    
    public func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
    
    }
    
    public func oauth20ConnectionDidFinishDeleteToken() {
        
    }
    
    public func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: (any Error)!) {
        
    }
}
