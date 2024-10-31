import SwiftUI
import Base
import DesignSystem

// MARK: HomeView

struct HomeView: IntentBindingType {
    @StateObject var container: Container<HomeIntentType, HomeModel.State>
    var intent: HomeIntentType { self.container.intent }
    var state: HomeModel.State { self.intent.state }
}

// MARK: Body

extension HomeView: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            
        }
        .task {
            
        }
    }
}

