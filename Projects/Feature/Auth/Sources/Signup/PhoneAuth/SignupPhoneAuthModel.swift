import Foundation
import SwiftUI

enum SignupPhoneAuthModel {
    struct State: Equatable {
        var phoneNumber: String = ""
        var authCode: String = ""
        
        var isShowAuthCodeField: Bool = false
        
        var isEnabledNextBtn: Bool = false
    }
    
    enum ViewAction: Equatable {
        case onAppear
        case changePhoneNumber(String?)
        case changeAuthCode(String?)
        case authBtnDidTap
        case nextBtnDidTap
    }
}

extension SignupPhoneAuthModel {
    enum FocusField {
        case phoneNumber
        case authCode
    }
}
