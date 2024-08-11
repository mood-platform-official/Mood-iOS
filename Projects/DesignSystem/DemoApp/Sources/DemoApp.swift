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
    
    var body: some Scene {
        WindowGroup {
            VStack(spacing: 20) {
                AssistiveButton(text: "disabled", disabled: false, action: {
                    self.disabled.toggle()
                })
                
                AssistiveButton(text: "123", rightIcon: .icClock, disabled: disabled, action: {
                    
                })
                
                AssistiveButton(text: "123", leftIcon: .icPin, disabled: disabled, action: {
                    
                })
                
                AssistiveButton(text: "123", leftIcon: .icPin, rightIcon: .icClock, disabled: disabled, action: {
                    
                })
            }
            .padding(.horizontal, 20)
            .frame(maxHeight: .infinity)
            .background(.white)
        }
    }
}
