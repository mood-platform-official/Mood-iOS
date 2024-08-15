import Foundation
import SwiftUI
import Dependencies

enum SignupPasswordModel {
    struct State: Equatable {
        var password: String = ""
        var passwordAgain: String = ""
        
        var pwBottomText: String = ""
        var pwAgainBottomText: String = ""
        var isDisabledNextBtn: Bool = false
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
