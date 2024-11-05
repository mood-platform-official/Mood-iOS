import SwiftUI
import NukeUI

public enum MeetingCardState {
    /// 빈자리가 3자리 이상 남은 경우
    case empty
    /// 모임 진행 시간까지 1시간 남았을 경우
    case soon
    /// 1 등록시간 지남,2 전부 모집, 3 모임 취소
    case end
    /// 내가 참여한한 모임일 경우
    case `in`
    /// 내가 등록한 모임일 경우
    case make
}

public struct MeetingCard: View {
    var state: MeetingCardState
    var imageURL: String
    var title: String
    var time: String
    var place: String
    var makerImageURL: String
    var emptyCount: String
    
    public init(state: MeetingCardState, imageURL: String, title: String, time: String, place: String, makerImageURL: String, emptyCount: String) {
        self.state = state
        self.imageURL = imageURL
        self.title = title
        self.time = time
        self.place = place
        self.makerImageURL = makerImageURL
        self.emptyCount = emptyCount
    }
    
    public var body: some View {
        VStack(alignment: .center, spacing: 12) {
            imageSection()
            infoSection()
                .padding(12)
            
        }
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.dividerGrey, lineWidth: 1)
        }
    }
}

extension MeetingCard {
    private var emptyCountColor: Color {
        (Int(emptyCount) ?? 0) > 3 ? Color.primary600 : Color.textBody
    }
}

extension MeetingCard {
    @ViewBuilder
    private func imageSection() -> some View {
        LazyImage(source: imageURL) { state in
            if let image = state.image {
                image.resizingMode(.center)
                    .frame(height: 83)
                    .frame(maxWidth: .infinity)
                    .clipped()
            } else {
                Image(.picture)
                    .resizable()
                    .frame(height: 83)
                    .frame(maxWidth: .infinity)
                    .clipped()
            }
        }
        .overlay(alignment: .bottomLeading) {
            stateBadge()
        }
    }
    
    @ViewBuilder
    private func infoSection() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .subtitle4(.medium)
                .foregroundStyle(Color.textHeading)
                .lineLimit(2)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(time)

                Text(place)
            }
            .caption2()
            .foregroundStyle(Color.textBody)
            
            Line()
                .frame(height: 1)
                .background(Color.dividerGrey)
            
            profileSection()
        }
    }
    
    @ViewBuilder
    private func profileSection() -> some View {
        HStack(alignment: .center, spacing: 0) {
            HStack(alignment: .center, spacing: 4) {
                ProfileCard(state: .default(url: ""), size: .small)
                
                ProfileCard(state: .add, size: .small)
            }
            
            Spacer()
            
            Text(emptyCount)
                .subtitle6(.regular)
                .foregroundStyle(emptyCountColor)
            Text("자리 남음")
                .subtitle6(.regular)
                .foregroundStyle(Color.textBody)
        }
    }
    
    @ViewBuilder
    private func stateBadge() -> some View {
        let text: String = {
            switch state {
            case .soon: "곧 시작해요"
            case .in: "나와 함께하는 모임"
            case .make: "내가 만든 모임"
            default: ""
            }
        }()
        
        let textColor: Color = {
            switch state {
            case .soon: Color.errorText
            case .in: Color.grey100
            case .make: Color.textBody
            default: Color.white
            }
        }()
        
        let bgColor: Color = {
            switch state {
            case .soon: Color.errorBackground
            case .in: Color.primary500
            case .make: Color.backgroundGrey
            default: Color.white
            }
        }()

        if state == .soon || state == .in || state == .make {
            Text(text)
                .caption2()
                .foregroundStyle(textColor)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(bgColor)
                .clipShape(.capsule)
                .padding(.bottom, 8)
                .padding(.leading, 8)
        } else {
            EmptyView()
        }
    }
}
