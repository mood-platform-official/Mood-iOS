import SwiftUI
import Base
import DesignSystem

// MARK: TermsView

struct TermsView: IntentBindingType {
    @StateObject var container: Container<TermsIntentType, TermsModel.State>
    var intent: TermsIntentType { self.container.intent }
    var state: TermsModel.State { self.intent.state }

    @SwiftUICore.State private var sliderValue: Double = 2.5
}

// MARK: Body

extension TermsView: View {

    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            OverlayLine(divideBy: 4)
        }
        .backTopBar(
            title: "회원가입",
            backAction: { self.intent.send(action: .back) }
        )
        .task {
            let image = UIImage(systemName: "")
            UISlider.appearance().setThumbImage(image, for: .normal)
            self.intent.send(action: .onAppear)
        }
    }
}
