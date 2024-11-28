import Foundation
import SwiftUI

enum NicknameModel {
    struct State: Equatable {
        var nickname: String = ""

        var isError: Bool = false
        var errorText: String = "닉네임은 특수문자를 제외한 숫자, 한글, 영문 대소문자 형식으로 2글자 이상 10글자 이하로 입력할 수 있어요."
        var isEnabledNextBtn: Bool = false
    }

    enum ViewAction: Equatable {
        case onAppear
        case back
        case changeNickname(String)
        case nextBtnDidTap
    }
}

extension NicknameModel {
    enum FocusField {
        case nickname
    }
}
