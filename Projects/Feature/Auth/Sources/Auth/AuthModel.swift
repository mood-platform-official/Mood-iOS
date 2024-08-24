import Foundation
import CoreKit
import Entity

enum AuthModel {
    struct State: Equatable {
        var focusField: FocusField?
        var email: String = ""
        
        var bottomText: String = ""
        var isEnabledEmailBtn: Bool { !email.isEmpty }
        var isErrorEmailBtn: Bool { !bottomText.isEmpty }
    }
    
    enum ViewAction: Equatable {
        case onAppear
        case changeEmail(String?)
        case emailBtnDidTap
        case kakaoBtnDidTap
        case naverBtnDidTap
        case appleBtnDidTap
        case findEmailBtnDidTap
        case findPWBtnDidTap
    }
}


extension AuthModel {
    enum FocusField {
        case email
    }
}
