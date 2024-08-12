import Foundation

enum AuthModel {
    struct State: Equatable {
        var focusField: FocusField?
        var email: String = ""
        var isError: Bool = false
        
        var bottomText: String = ""
    }
    
    enum ViewAction: Equatable {
        case onAppear
        case changeEmail(String?)
        case changeError(Bool)
    }
}


extension AuthModel {
    enum FocusField {
        case email
    }
}
