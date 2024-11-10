import Foundation
import SwiftUI
import Base
import DesignSystem
import Logger

// MARK: NicknameView

struct NicknameView: IntentBindingType {
    @StateObject var container: Container<NicknameIntentType, NicknameModel.State>
    var intent: NicknameIntentType { self.container.intent }
    var state: NicknameModel.State { self.intent.state }
    
    init(container: Container<NicknameIntentType, NicknameModel.State>) {
        self._container = StateObject(wrappedValue: container)
        
        Log.debug("NicknameView init")
    }
}

// MARK: Body

extension NicknameView: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            OverlayLine(divideBy: 2)
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
