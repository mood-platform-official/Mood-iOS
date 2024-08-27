import AuthenticationServices
import Foundation

public enum AppleError: Error {
    case canceled
    case error(Error)
    case message(String)
}

public protocol AppleDelegate {
    func performRequests(_ result: Result<String, AppleError>)
}

public final class AppleClient: NSObject, AppleDelegate {
    public override init() {}

    public func performRequests(_ result: Result<String, AppleError>) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

extension AppleClient: ASAuthorizationControllerPresentationContextProviding {
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        let scene = UIApplication.shared.connectedScenes
        let windowScene = scene.first as? UIWindowScene
        let window = windowScene?.windows.first
        
        return window!
    }
}

extension AppleClient: ASAuthorizationControllerDelegate {
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        if let err = error as? ASAuthorizationError {
            if err.code == .canceled || err.code == .unknown {
                performRequests(.failure(.canceled))
            } else {
                performRequests(.failure(.error(err)))
            }
        } else {
            performRequests(.failure(.error(error)))
        }
    }

    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard
            let credentials = authorization.credential as? ASAuthorizationAppleIDCredential,
            let identityToken = credentials.identityToken,
            let identityTokenString = String(data: identityToken, encoding: .utf8)
        else {
            performRequests(.failure(.message("Failed to receive authorization token.")))
            return
        }
        performRequests(.success(identityTokenString))
    }
}
