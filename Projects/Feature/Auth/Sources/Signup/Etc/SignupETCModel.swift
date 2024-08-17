import Foundation
import SwiftUI

enum SignupETCModel {
    struct State: Equatable {
        var name: String = ""
        var birthDay: String = ""
        var nickname: String = ""
        
        var nameBottomText: String = ""
        var birthDayBottomText: String = ""
        var nickNameBottomText: String = ""
        
        var isShowBirthDayField: Bool = false
        var isShowNicknameField: Bool = false
        
        var isEnabledNextBtn: Bool = false
    }
    
    enum ViewAction: Equatable {
        case onAppear
        case changeName(String?)
        case onSubmitName
        
        case changeBirthDay(String?)
        case onSubmitBirthDay
        
        case changeNickname(String?)
        case onSubmitNickname
        
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
