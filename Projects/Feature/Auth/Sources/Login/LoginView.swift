import DesignSystem
import Base
import SwiftUI

// MARK: LoginView

struct LoginView: IntentBindingType {
    @StateObject var container: Container<LoginIntentType, LoginModel.State>
    var intent: LoginIntentType { self.container.intent }
    var state: LoginModel.State { self.intent.state }
}

// MARK: Body

extension LoginView: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            
        }
        .task {
            self.intent.send(action: .onAppear)
        }
    }
}
