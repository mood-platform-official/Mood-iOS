import Foundation
import SwiftUI

enum SignupETCModel {
    struct State: Equatable {
        var name: String = ""
        var birthDay: String = ""
        var nickname: String = ""
        
        var isDisabledNextBtn: Bool = false
    }
    
    enum ViewAction: Equatable {
        case onAppear
        case changeName(String?)
        case changeBirthDay(String?)
        case changeNickname(String?)
        case nextBtnDidTap
    }
}

extension SignupETCModel {
    enum FocusField {
        case name
        case birthDay
        case nickname
    }
}
