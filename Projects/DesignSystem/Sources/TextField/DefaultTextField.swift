import SwiftUI
import Entity

public enum DefaultTextFieldSize: CGFloat {
    case small = 8
    case regular = 12
    case large = 14
}

public struct DefaultTextField<Value: Hashable>: View {
    private let size: DefaultTextFieldSize
    private let isSecure: Bool
    private let placeholder: String
    @Binding private var text: String
    private var focusedField: (binding: FocusState<Value?>.Binding, equals: Value?)
    private let disabled: Bool
    @Binding private var isError: Bool
    @Binding private var isSuccess: Bool
    private var leftBottom: Entity.UI.BottomText?
    private var rightBottom: Entity.UI.BottomText?
    private var leftIcon: Image?
    private var rightButton: Entity.UI.RightButton?
    
    private var hasBottomText: Bool {
        (leftBottom?.text.count ?? 0) > 0 || (rightBottom?.text.count ?? 0) > 0
    }
    
    private var backgroundColor: Color {
        disabled ? .backgroundGrey : .white
    }
    
    private var strokeColor: Color {
        if focusedField.binding.wrappedValue == focusedField.equals {
            return .primary500
        } else if isError {
            return .errorMain
        } else if isSuccess {
            return .successMain
        } else {
            return .dividerGrey
        }
    }
    
    public init(
        size: DefaultTextFieldSize = .regular,
        isSecure: Bool = false,
        placeholder: String,
        text: Binding<String>,
        focusedField: (binding: FocusState<Value?>.Binding, equals: Value?),
        disabled: Bool = false,
        isError: Binding<Bool> = .constant(false),
        isSuccess: Binding<Bool> = .constant(false),
        leftBottom: Entity.UI.BottomText? = nil,
        rightBottom: Entity.UI.BottomText? = nil,
        rightButton: Entity.UI.RightButton? = nil,
        leftIcon: Image? = nil
    ) {
        self.size = size
        self.isSecure = isSecure
        self.placeholder = placeholder
        self._text = text
        self.focusedField = focusedField
        self.disabled = disabled
        self._isError = isError
        self._isSuccess = isSuccess
        self.leftBottom = leftBottom
        self.rightBottom = rightBottom
        self.rightButton = rightButton
        self.leftIcon = leftIcon
    }
    
    public var body: some View {
        VStack(spacing: 6) {
            TextFieldRow(
                size: size,
                isSecure: isSecure,
                placeholder: placeholder,
                text: $text,
                backgroundColor: backgroundColor,
                strokeColor: strokeColor,
                rightButton: rightButton,
                leftIcon: leftIcon,
                isDisabled: disabled,
                isError: $isError,
                isSuccess: $isSuccess
            )
            .focused(focusedField.binding, equals: focusedField.equals)
            .disabled(disabled)
            .onChange(of: text) { oldValue, newValue in
                updateErrorState(oldValue: oldValue, newValue: newValue)
            }
            
            if hasBottomText {
                BottomRow(
                    leftBottom: leftBottom,
                    rightBottom: rightBottom,
                    isError: $isError,
                    isSuccess: $isSuccess
                )
            }
        }
    }
    
    private func updateErrorState(oldValue: String, newValue: String) {
        if isError {
            isError = oldValue == newValue
        }
        if isSuccess {
            isSuccess = oldValue == newValue
        }
    }
}
