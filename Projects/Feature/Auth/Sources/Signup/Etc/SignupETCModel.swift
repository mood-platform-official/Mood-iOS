import Foundation
import SwiftUI

enum SignupETCModel {
    struct State: Equatable {
        var name: String = ""
        var birthDay: Date? = nil
        var nickname: String = ""
        
        var nameBottomText: String = ""
        var nickNameBottomText: String = ""
        
        var isShowBirthDayField: Bool = false
        var isShowNicknameField: Bool = false
        
        var isEnabledNextBtn: Bool = false
    }
    
    enum ViewAction: Equatable {
        case onAppear
        case changeName(String?)
        case onSubmitName
        
        case changeBirthDay(Date?)
        case onSubmitBirthDay
        
        case changeNickname(String?)
        case onSubmitNickname
        
        case nextBtnDidTap
    }
}

extension SignupETCModel {
    enum FocusField {
        case name
        case nickname
    }
}
