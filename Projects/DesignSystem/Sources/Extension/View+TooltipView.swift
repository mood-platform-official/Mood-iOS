import SwiftUI

extension View {
    public func primaryTooltip(
        text: String,
        alignment: Edge,
        isVisible: Binding<Bool>,
        isAnimating: Bool = false
    ) -> some View {
        modifier(
            TooltipModifier(
                text: text,
                alignment: alignment,
                state: .primary,
                isVisible: isVisible,
                isAnimating: isAnimating
            )
        )
    }
    
    public func tooltip(
        text: String,
        alignment: Edge,
        isVisible: Binding<Bool>,
        isAnimating: Bool = false
    ) -> some View {
        modifier(
            TooltipModifier(
                text: text,
                alignment: alignment,
                state: .default,
                isVisible: isVisible,
                isAnimating: isAnimating
            )
        )
    }
}
