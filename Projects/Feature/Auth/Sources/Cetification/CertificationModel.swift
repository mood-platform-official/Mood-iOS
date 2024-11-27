import SwiftUI

enum CertificationModel {
    struct State: Equatable {
        var phone: String = ""

        var isError: Bool = false
        var errorText: String = "휴대폰 번호를 입력해주세요"

        var isEnabledDoneBtn: Bool = false
    }

    enum ViewAction: Equatable {
        case onAppear
        case back

        case changePhoneNumber(String)

        case authBtnDidTap
        case doneBtnDidTap
    }
}

extension CertificationModel {
    enum FocusField {
        case phoneAuth
    }
}
