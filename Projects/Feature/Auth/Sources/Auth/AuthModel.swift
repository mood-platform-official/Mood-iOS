import Foundation
import CoreKit
import Entity

enum AuthModel {
    struct State: Equatable {
        
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
}
