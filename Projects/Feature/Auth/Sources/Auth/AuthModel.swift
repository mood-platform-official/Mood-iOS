import Foundation
import CoreKit

enum AuthModel {
    struct State: Equatable {
        var focusField: FocusField?
        var email: String = ""
        
        var bottomText: String = ""
        var isDisabledEmailBtn: Bool = false
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
