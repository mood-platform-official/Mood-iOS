import Foundation
import SwiftUI
import Dependencies

enum FindPasswordModel {
    struct State: Equatable {
        var focusField: FocusField?
        var phoneNumber: String = ""
        var email: String = ""
        
        var bottomText: String = ""
        var isDisabledAuthenticationNumberBtn: Bool = false
    }
    
    enum ViewAction: Equatable {
        case onAppear
        case changePhoneNumber(String?)
        case changeEmail(String?)
        case authenticationNumberBtnDidTap
    }
}

extension FindPasswordModel {
    enum FocusField {
        case phone
        case email
    }
}
