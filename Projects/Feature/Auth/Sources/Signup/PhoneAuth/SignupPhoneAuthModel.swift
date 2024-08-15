import Foundation
import SwiftUI

enum SignupPhoneAuthModel {
    struct State: Equatable {
        var phoneNumber: String = ""
        var authCode: String = ""
        
        var isDisabledNextBtn: Bool = false
    }
    
    enum ViewAction: Equatable {
        case onAppear
        case changePhoneNumber(String?)
        case changeAuthCode(String?)
        case nextBtnDidTap
    }
}

extension SignupPhoneAuthModel {
    enum FocusField {
        case phoneNumber
        case authCode
    }
}
