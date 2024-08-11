import SwiftUI

public struct DefaultTextField<value: Hashable>: View {
    let placeholder: String
    @Binding var text: String
    var focusedField: (binding: FocusState<value?>.Binding, equals: value?)
    var disabled: Bool
    @Binding var isError: Bool
    
    var leftBottom: BottomText?
    var rightBottom: BottomText?
    
    var rightBtn: RightButton?
    
    var hasBottom: Bool { leftBottom?.text.count ?? 0 > 0 || rightBottom?.text.count ?? 0 > 0 }
    var bgColor: Color { disabled ? .gray75 : .white }
    var strokeColor: Color {
        if focusedField.binding.wrappedValue == focusedField.equals {
            return .gray600
        } else if isError {
            return .rubyRed
        } else {
            return .gray200
        }
    }
    
    public init(
        placeholder: String,
        text: Binding<String>,
        focusedField: (binding: FocusState<value?>.Binding, equals: value?),
        disabled: Bool,
        isError: Binding<Bool>,
        leftBottom: BottomText? = nil,
        rightBottom: BottomText? = nil,
        rightBtn: RightButton? = nil
    ) {
        self.placeholder = placeholder
        self._text = text
        self.focusedField = focusedField
        self.disabled = disabled
        self._isError = isError
        self.leftBottom = leftBottom
        self.rightBottom = rightBottom
        self.rightBtn = rightBtn
    }
    
    public var body: some View {
        VStack(spacing: 6) {
            TextFieldRow(placeholder, $text, bgColor, strokeColor, rightBtn)
                .focused(focusedField.binding, equals: focusedField.equals)
                .disabled(disabled)
                .onChange(of: text) { oldValue, newValue in
                    if isError {
                        isError = oldValue == newValue
                    }
                }
            
            if hasBottom {
                BottomRow(leftBottom, rightBottom)
            }
        }
    }
}
