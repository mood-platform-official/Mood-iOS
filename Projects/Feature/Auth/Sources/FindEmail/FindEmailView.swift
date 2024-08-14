import DesignSystem
import Base
import SwiftUI

// MARK: FindEmailView

struct FindEmailView: IntentBindingType {
    @StateObject var container: Container<FindEmailIntentType, FindEmailModel.State>
    var intent: FindEmailIntentType { self.container.intent }
    var state: FindEmailModel.State { self.intent.state }
    
    @Environment(\.dismiss) private var dismiss
}

// MARK: Body

extension FindEmailView: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            
        }
        .backTopBar(title: "이메일 찾기", backAction: { self.dismiss() })
        .task {
            self.intent.send(action: .onAppear)
        }
    }
}
