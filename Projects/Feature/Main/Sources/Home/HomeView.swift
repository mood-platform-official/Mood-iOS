import SwiftUI
import Base
import DesignSystem
import Logger

// MARK: HomeView

struct HomeView: IntentBindingType {
    @StateObject var container: Container<HomeIntentType, HomeModel.State>
    var intent: HomeIntentType { self.container.intent }
    var state: HomeModel.State { self.intent.state }
    
    init(container: Container<HomeIntentType, HomeModel.State>) {
        self._container = StateObject(wrappedValue: container)
        
        Log.debug("HomeView init")
    }
}

// MARK: Body

extension HomeView: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            fakeSearchBar()
            weekSection()
                .padding(.horizontal, 16)
            Line()
                .frame(height: 1)
                .background(Color.dividerGrey)
            if state.meetings.isEmpty {
                emptyWarningText()
            } else {
                meetingCardSection()
            }
        }
        .task {
            self.intent.send(action: .onAppear)
        }
    }
}

// MARK: Custom View

extension HomeView {
    @ViewBuilder
    private func fakeSearchBar() -> some View {
        HStack(alignment: .center, spacing: 12) {
            Image.icHomeLogo
                .resizable()
                .frame(width: 48, height: 48)
            
            HStack(alignment: .center, spacing: 10) {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .foregroundStyle(Color.grey800)
                    .frame(width: 16, height: 16)
                
                Text("오늘 나의 무드는?")
                    .body3()
                    .foregroundStyle(Color.textTertiary)
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 4)
            .padding(.vertical, 2)
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.dividerGrey, lineWidth: 1.0)
            }
            
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
    
    @ViewBuilder
    private func weekSection() -> some View {
        let columns = Array(repeatElement(GridItem(spacing: 0), count: 8))
        LazyVGrid(columns: columns) {
            ForEach(self.state.dayOfWeek, id: \.day) { dayOfWeek in
                DateCard(
                    day: dayOfWeek.day,
                    dayOfWeek: dayOfWeek.dayOfWeek,
                    isSelected: dayOfWeek.isSelected,
                    action: {
                        self.intent.send(action: .selectedDateCard(dayOfWeek))
                    }
                )
            }
        }
        .padding(.top, 4)
        .padding(.bottom, 12)
    }
    
    private struct DateCard: View {
        var day: String
        var dayOfWeek: String
        var isSelected: Bool
        var action: () -> Void
        
        private var textColor: Color { isSelected ? Color.primary500 : Color.textTertiary }
        
        var body: some View {
            Button {
                self.action()
            } label: {
                VStack(alignment: .center, spacing: 0) {
                    Text(day)
                        .subtitle5(.bold)
                        .foregroundStyle(textColor)
                    
                    Text(dayOfWeek)
                        .caption1()
                        .foregroundStyle(textColor)
                }
                .frame(height: 56)
                .frame(maxWidth: .infinity)
            }
            .background {
                if isSelected {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.primary50)
                        .stroke(Color.primary200, lineWidth: 1.0)
                }
            }
        }
    }
    
    @ViewBuilder
    private func emptyWarningText() -> some View {
        VStack(alignment: .center) {
            Spacer()
            Text("진행중인 모임이 없어요")
                .subtitle4(.regular)
                .foregroundStyle(Color.textTertiary)
            Spacer()
            
            Line()
                .frame(height: 1)
                .primaryTooltip(
                    text: "함께 할 수 있는 모임을 먼저 등록해보세요!",
                    alignment: .top,
                    isVisible: .constant(true),
                    isAnimating: true
                )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    @ViewBuilder
    private func meetingCardSection() -> some View {
        let columns: [GridItem] = Array(repeatElement(GridItem(), count: 2))
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: columns) {
                ForEach(state.meetings, id: \.id) { meeting in
                    MeetingCard(
                        state: meeting.state,
                        imageURL: meeting.imageURL,
                        title: meeting.title,
                        time: meeting.time,
                        place: meeting.place,
                        makerImageURL: meeting.makerImageURL,
                        emptyCount: meeting.emptyCount
                    )
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 24)
        }
    }
}
