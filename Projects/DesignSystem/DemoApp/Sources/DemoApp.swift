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
                ProfileCard(state: .delete(url: ""), size: .small)
                
                ProfileCard(state: .delete(url: ""))
                
                ProfileCard(state: .delete(url: ""), size: .large)
                
                ProfileCard(state: .disabled(url: ""), size: .large)
                
                ProfileCard(state: .disabled(url: ""), size: .regular)
                
                ProfileCard(state: .disabled(url: ""), size: .small)
            }
            .padding(.horizontal, 20)
            .frame(maxHeight: .infinity)
            .background(.white)
        }
    }
}
