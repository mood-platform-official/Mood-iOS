import Foundation
import SwiftUI
import Dependencies

enum SignupTermsModel {
    struct State: Equatable {
        
    }
    
    enum ViewAction: Equatable {
        case onAppear
        
        case serviceTermsBtnDidTap
        case personalTermsBtnDidTap
        case marketingTermsBtnDidTap
        
        case nextBtnDidTap
    }
}
