import SwiftUI

public struct DefaultTextField<value: Hashable>: View {
    let placeholder: String
    @Binding var text: String
    var focusedField: (binding: FocusState<value?>.Binding, equals: value?)
    var disabled: Bool
    
    
    public init(
        placeholder: String,
        text: Binding<String>,
        focusedField: (binding: FocusState<value?>.Binding, equals: value?),
        disabled: Bool
    ) {
        self.placeholder = placeholder
        self._text = text
        self.focusedField = focusedField
        self.disabled = disabled
    }
    
    public var body: some View {
        TextField(placeholder, text: $text)
            .padding(.horizontal, 16)
            .padding(.vertical, 11)
            .background {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(disabled ? .scaleGray75 : .scaleWhite))
            }
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color(.scaleGray200), lineWidth: 1.0)
            )
            .body1()
            .focused(focusedField.binding, equals: focusedField.equals)
            .disabled(disabled)
    }
}
