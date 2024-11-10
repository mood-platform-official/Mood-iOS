import Foundation
import SwiftUI
import Dependencies

enum NicknameModel {
    struct State: Equatable {
        var nickname: String = ""
    }
    
    enum ViewAction: Equatable {
        case onAppear
        case back
    }
}
