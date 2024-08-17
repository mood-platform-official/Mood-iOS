import Foundation
import SwiftUI

enum FindEmailModel {
    struct State: Equatable {
        var focusField: FocusField?
        var phoneNumber: String = ""
        
        var bottomText: String = ""
        var isEnabledFindEmailBtn: Bool { phoneNumber.isValidPhone() }
        var isErrorFindEmailBtn: Bool { !bottomText.isEmpty }
    }
    
    enum ViewAction: Equatable {
        case onAppear
        case changePhoneNumber(String?)
        case findEmailBtnDidTap
    }
}

extension FindEmailModel {
    enum FocusField {
        case phone
    }
}
