import SwiftUI

extension View {
    public func primaryTooltip(
        text: String,
        alignment: Edge,
        isVisible: Binding<Bool>
    ) -> some View {
        modifier(
            TooltipModifier(
                text: text,
                alignment: alignment,
                state: .primary,
                isVisible: isVisible
            )
        )
    }
    
    public func tooltip(
        text: String,
        alignment: Edge,
        isVisible: Binding<Bool>
    ) -> some View {
        modifier(
            TooltipModifier(
                text: text,
                alignment: alignment,
                state: .default,
                isVisible: isVisible
            )
        )
    }
}
