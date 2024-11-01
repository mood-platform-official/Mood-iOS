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
        VStack(alignment: .leading, spacing: 32) {
            fakeSearchBar()
            
            Spacer()
        }
        .task {
            
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
}
