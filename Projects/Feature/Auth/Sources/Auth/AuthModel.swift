import Foundation
import CoreKit
import Entity

enum AuthModel {
    struct State: Equatable {
        var focusField: FocusField?
        var email: String = ""
        
        var bottomText: String = ""
        var isEnabledEmailBtn: Bool { email.isValidEmail() && !email.isEmpty }
        var isErrorEmailBtn: Bool { !bottomText.isEmpty }
    }
    
    enum ViewAction: Equatable {
        case onAppear
        case changeEmail(String?)
        case emailBtnDidTap
    }
}


extension AuthModel {
    enum FocusField {
        case email
    }
}
