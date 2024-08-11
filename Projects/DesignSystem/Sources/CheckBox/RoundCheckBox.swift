import SwiftUI

public struct RoundCheckBox: View {
    
    var state: CheckBoxState = .unchecked
    var disabled: Bool
    var action: (CheckBoxState) -> Void
    
    var bgColor: Color { state == .unchecked ? .white : .primary500 }
    var strokeColor: Color { state == .unchecked ? .gray300 : .clear }
    var icon: Image {
        switch state {
        case .unchecked:
            Image.icCheckThickness20
        case .checked:
            Image.icCheckThickness20
        case .partial:
            Image.icMinusThickness20
        }
    }
    
    public init(state: CheckBoxState = .unchecked, disabled: Bool = false, action: @escaping (CheckBoxState) -> Void) {
        self.state = state
        self.disabled = disabled
        self.action = action
    }
    
    public var body: some View {
        Button {
            action(state)
        } label: {
            Image.icCheckThickness20
                .resizable()
                .renderingMode(.template)
                .foregroundStyle(state == .unchecked ? .clear : .white)
                .frame(width: 16, height: 16)
                .padding(2)
                .background {
                    Circle().fill(bgColor)
                }
                .overlay(
                    Circle().stroke(strokeColor, lineWidth: 1.0)
                )
        }
        .disabled(disabled)
    }
}
