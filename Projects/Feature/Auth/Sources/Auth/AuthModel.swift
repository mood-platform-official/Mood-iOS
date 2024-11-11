import Foundation
import CoreKit
import Entity

enum AuthModel {
    struct State: Equatable, Codable {
        var registerInfo: RegisterInfo?
    }

    enum ViewAction: Equatable {
        case onAppear
        case kakaoBtnDidTap
        case naverBtnDidTap
        case appleBtnDidTap
    }
}

extension AuthModel {
    enum FocusField {
        case email
    }
    
    struct ITEM {
        var oauthToken: String
        var idToken: String
    }
}
