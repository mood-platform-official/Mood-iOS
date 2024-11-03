import SwiftUI
import DesignSystem

@main
struct AuthApp: App {
    
    @State var isVisible: Bool = true
    var alignment: Edge = .top
    
    init() {
        DesignSystemFontFamily.registerAllCustomFonts()
    }
    
    var body: some Scene {
        WindowGroup {
            VStack(spacing: 20) {
                Button {
                    self.isVisible.toggle()
                } label: {
                    Text("Tooltip Test")
                }
                .tooltip(text: "Tooltip on Top", alignment: .top, isVisible: $isVisible)
                
                Button {
                    self.isVisible.toggle()
                } label: {
                    Text("Tooltip Test")
                }
                .primaryTooltip(text: "Tooltip on Bottom", alignment: .bottom, isVisible: $isVisible)
            }
            .padding(.horizontal, 20)
            .frame(maxHeight: .infinity)
            .background(.white)
        }
    }
}
