import SwiftUI
import DesignSystem
import Entity

enum HomeModel {
    struct State: Equatable {
        var dayOfWeek: [DayOfWeek] = []
        var meetings: [Meeting] = []
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

    struct Meeting: Hashable, Identifiable {
        let id: String
        var state: MeetingCardState
        var imageURL: String
        var title: String
        var time: String
        var place: String
        var makerImageURL: String
        var emptyCount: String
    }
}
