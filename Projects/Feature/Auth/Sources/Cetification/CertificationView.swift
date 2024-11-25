import SwiftUI
import DesignSystem
import Base
import Logger

// MARK: CertificationView

struct CertificationView: IntentBindingType {
    @StateObject var container: Container<CertificationIntentType, CertificationModel.State>
    var intent: CertificationIntentType { self.container.intent }
    var state: CertificationModel.State { self.intent.state }
}

// MARK: Body

extension CertificationView: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            
        }
        .backTopBar(
            title: "회원가입",
            backAction: { self.intent.send(action: .back) }
        )
        .task {
            self.intent.send(action: .onAppear)
        }
    }
}
