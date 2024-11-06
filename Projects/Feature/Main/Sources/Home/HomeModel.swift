import SwiftUI
import Entity

enum HomeModel {
    struct State: Equatable {
        var dayOfWeek: [DayOfWeek] = []
    }
    
    enum ViewAction: Equatable {
        case onAppear
        case selectedDateCard(DayOfWeek)
    }
}

extension HomeModel {
    struct DayOfWeek: Hashable {
        let day: String
        let dayOfWeek: String
        var isSelected: Bool
    }
}
