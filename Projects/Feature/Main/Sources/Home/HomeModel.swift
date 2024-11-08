import SwiftUI
import DesignSystem
import Entity

enum HomeModel {
    struct State: Equatable {
        var dayOfWeek: [DayOfWeek] = []
        var meetings: [Meeting] = .testValue
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

extension [HomeModel.Meeting] {
    static var testValue: Self = [
        .init(
            id: "1",
            state: .empty,
            imageURL: "",
            title: "저녁먹을 사람 구해요 비빔국수에 보쌈 편육 맛있게 드실분",
            time: "오후 7시 30분",
            place: "장비빔국수 미금점",
            makerImageURL: "",
            emptyCount: "1"
        ),
        .init(
            id: "2",
            state: .end,
            imageURL: "",
            title: "저녁먹을 사람 구해요 비빔국수에 보쌈 편육 맛있게 드실분",
            time: "오후 7시 30분",
            place: "장비빔국수 미금점",
            makerImageURL: "",
            emptyCount: "1"
        ),
        .init(
            id: "3",
            state: .in,
            imageURL: "",
            title: "저녁먹을 사람 구해요 비빔국수에 보쌈 편육 맛있게 드실분",
            time: "오후 7시 30분",
            place: "장비빔국수 미금점",
            makerImageURL: "",
            emptyCount: "1"
        ),
        .init(
            id: "4",
            state: .make,
            imageURL: "",
            title: "저녁먹을 사람 구해요 비빔국수에 보쌈 편육 맛있게 드실분",
            time: "오후 7시 30분",
            place: "장비빔국수 미금점",
            makerImageURL: "",
            emptyCount: "1"
        ),
        .init(
            id: "5",
            state: .soon,
            imageURL: "",
            title: "저녁먹을 사람 구해요 비빔국수에 보쌈 편육 맛있게 드실분",
            time: "오후 7시 30분",
            place: "장비빔국수 미금점",
            makerImageURL: "",
            emptyCount: "1"
        )
    ]
}
