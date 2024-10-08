import Foundation
import SwiftUI

enum SignupPasswordModel {
    struct State: Equatable {
        var password: String = ""
        var passwordAgain: String = ""
        
        var pwBottomText: String = ""
        var pwAgainBottomText: String = ""
        var isEnabledNextBtn: Bool { !password.isEmpty && !passwordAgain.isEmpty }
        var isErrorPWRow: Bool { !pwBottomText.isEmpty }
        var isErrorPWAgainRow: Bool { !pwAgainBottomText.isEmpty }
    }
    
    enum ViewAction: Equatable {
        case onAppear
        case changePassword(String?)
        case changePasswordAgain(String?)
        case nextBtnDidTap
    }
}

extension SignupPasswordModel {
    enum FocusField {
        case password
        case passwordAgain
    }
}
