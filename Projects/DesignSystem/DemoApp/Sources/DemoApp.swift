import SwiftUI
import DesignSystem

@main
struct AuthApp: App {
    
    @State var isVisible: Bool = true
    var alignment: Edge = .top
    
    var columns = Array(repeatElement(GridItem(), count: 2))
    var array: [MeetingCardState] = [.empty, .end, .in, .make, .soon]
    
    init() {
        DesignSystemFontFamily.registerAllCustomFonts()
    }
    
    var body: some Scene {
        WindowGroup {
            ScrollView(.vertical) {
                LazyVGrid(columns: columns) {
                    ForEach(array, id: \.hashValue) { state in
                        MeetingCard(state: .soon, imageURL: "", title: "저녁먹을 사람 구해요 비빔국수에 보쌈 편육 맛있게 드실분", time: "오후 7시 30분", place: "장비빔국수 미금점", makerImageURL: "", emptyCount: "1")
                    }
                }
            }
            .padding(.horizontal, 16)
            .background(.white)
        }
    }
}
