import Foundation
import SwiftUI
import Dependencies

enum LoginModel {
    struct State: Equatable {
        var focusField: FocusField?
        var password: String = ""
        
        var bottomText: String = ""
        var isDisabledLoginBtn: Bool = false
    }
    
    enum ViewAction: Equatable {
        case onAppear
        case changePassword(String?)
        case loginBtnDidTap
        case findPWBtnDidTap
    }
}

extension LoginModel {
    enum FocusField {
        case password
    }
}
