import SwiftUI
import Entity

extension DefaultTextField {
    struct TextFieldRow: View {
        private let size: DefaultTextFieldSize
        private let isSecure: Bool
        private let placeholder: String
        @Binding private var text: String
        private let backgroundColor: Color
        private let strokeColor: Color
        private let rightButton: Entity.UI.RightButton?
        private let leftIcon: Image?
        private let isDisabled: Bool
        @Binding private var isError: Bool
        @Binding private var isSuccess: Bool
        
        init(
            size: DefaultTextFieldSize,
            isSecure: Bool,
            placeholder: String,
            text: Binding<String>,
            backgroundColor: Color,
            strokeColor: Color,
            rightButton: Entity.UI.RightButton? = nil,
            leftIcon: Image? = nil,
            isDisabled: Bool = false,
            isError: Binding<Bool> = .constant(false),
            isSuccess: Binding<Bool> = .constant(false)
        ) {
            self.size = size
            self.isSecure = isSecure
            self.placeholder = placeholder
            self._text = text
            self.backgroundColor = backgroundColor
            self.strokeColor = strokeColor
            self.rightButton = rightButton
            self.leftIcon = leftIcon
            self.isDisabled = isDisabled
            self._isError = isError
            self._isSuccess = isSuccess
        }
        
        private var foregroundColor: Color {
            if isDisabled {
                return .textDisabled
            } else if isError {
                return .errorText
            } else if isSuccess {
                return .successText
            } else {
                return .grey900
            }
        }
        
        private var rightButtonColor: Color {
            if isDisabled {
                return .textDisabled
            } else if isError {
                return .errorText
            } else if isSuccess {
                return .successText
            } else {
                return rightButton?.defaultColor ?? .textSecondary
            }
        }
        
        var body: some View {
            HStack(spacing: 10) {
                if let leftIcon {
                    leftIcon
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 16, height: 16)
                        .foregroundStyle(isDisabled ? .textDisabled : Color.grey800)
                }
                
                if isSecure {
                    SecureField(placeholder, text: $text)
                        .frame(height: 26)
                        .foregroundStyle(foregroundColor)
                } else {
                    TextField(placeholder, text: $text)
                        .frame(height: 26)
                        .foregroundStyle(foregroundColor)
                }
                
                if let rightButton {
                    Button {
                        rightButton.action()
                    } label: {
                        HStack(spacing: 10) {
                            if let image = rightButton.image {
                                image
                                    .resizable()
                                    .renderingMode(.template)
                                    .frame(width: 16, height: 16)
                                    .foregroundStyle(rightButtonColor)
                            }
                            
                            Text(rightButton.text)
                                .foregroundStyle(rightButtonColor)
                        }
                        .body3()
                    }
                    .disabled(!rightButton.isEnabled)
                }
            }
            .body1()
            .padding(.horizontal, 16)
            .padding(.vertical, size.rawValue)
            .background {
                RoundedRectangle(cornerRadius: 12)
                    .fill(backgroundColor)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(strokeColor, lineWidth: 1.0)
            )
        }
    }
}
