import SwiftUI
import DesignSystem


enum FocusField {
    case one
    case two
    case three
}

@main
struct AuthApp: App {
    
    @State var disabled: Bool = false
    @State var state: CheckBoxState = .unchecked
    
    var body: some Scene {
        WindowGroup {
            VStack(spacing: 20) {
                RoundCheckBox(state: state, disabled: false, action: { state in
                    if state == .unchecked {
                        self.state = .checked
                    } else if state == .checked {
                        self.state = .unchecked
                    }
                })
                
                DefaultCheckBox(state: state, disabled: false, action: { state in
                    if state == .unchecked {
                        self.state = .checked
                    } else if state == .checked {
                        self.state = .unchecked
                    }
                })
            }
            .padding(.horizontal, 20)
            .frame(maxHeight: .infinity)
            .background(.white)
        }
    }
}
