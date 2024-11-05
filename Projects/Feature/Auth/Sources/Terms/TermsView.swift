import SwiftUI
import Base
import DesignSystem

// MARK: TermsView

struct TermsView: IntentBindingType {
    @StateObject var container: Container<TermsIntentType, TermsModel.State>
    var intent: TermsIntentType { self.container.intent }
    var state: TermsModel.State { self.intent.state }
}

// MARK: Body

extension TermsView: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            
        }
        .task {
            self.intent.send(action: .onAppear)
        }
    }
}
