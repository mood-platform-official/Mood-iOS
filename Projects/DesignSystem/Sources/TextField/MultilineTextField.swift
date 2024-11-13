import SwiftUI
import Entity

public struct MultilineTextField<Value: Hashable>: View {
    
    // MARK: Properties
    private let placeholder: String
    @Binding private var text: String
    private var focusedField: (binding: FocusState<Value?>.Binding, equals: Value?)
    @Binding private var isError: Bool
    private var leftBottom: Entity.UI.BottomText?
    private var rightBottom: Entity.UI.BottomText?
    private var minLines: Int
    private var maxLines: Int
    private var maxLength: Int?
    
    
    // MARK: Init
    public init(
        maxLength: Int? = nil,
        placeholder: String = "내용을 입력해주세요",
        text: Binding<String>,
        focusedField: (binding: FocusState<Value?>.Binding, equals: Value?),
        isError: Binding<Bool>,
        leftBottom: Entity.UI.BottomText? = nil,
        rightBottom: Entity.UI.BottomText? = nil,
        minLines: Int = 4,
        maxLines: Int = 7
    ) {
        self.maxLength = maxLength
        self.placeholder = placeholder
        self._text = text
        self.focusedField = focusedField
        self._isError = isError
        self.leftBottom = leftBottom
        self.rightBottom = rightBottom
        self.minLines = minLines
        self.maxLines = maxLines
    }
    
    
    // MARK: Body
    public var body: some View {
        VStack(spacing: 8) {
            multilineTextField()
            
            if hasBottomText {
                BottomRow(
                    leftBottom: leftBottom,
                    rightBottom: rightBottom,
                    isError: $isError,
                    isSuccess: .constant(false)
                )
            }
        }
    }
}

// MARK: TextField
extension MultilineTextField {
    @ViewBuilder
    func multilineTextField() -> some View {
        VStack(alignment: .trailing, spacing: 4) {
            TextField(placeholder, text: $text, axis: .vertical)
                .body3()
                .foregroundStyle(foregroundColor)
                .lineLimit(minLines...maxLines)
                .autocorrectionDisabled(true)
                .onChange(of: text) { oldValue, newValue in
                    if isError {
                        isError = oldValue == newValue
                    }
                    if let maxLength {
                        if newValue.count > maxLength {
                            text = String(newValue.prefix(maxLength))
                        }
                    }
                }
            
            if let maxLength {
                Text("\(text.count)/\(maxLength)")
                    .caption2()
                    .foregroundStyle(captionColor)
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(backgroundColor)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(strokeColor, lineWidth: 1.0)
        )
        .focused(focusedField.binding, equals: focusedField.equals)
    }
    
}

// MARK: Computed properties
extension MultilineTextField {
    private var hasBottomText: Bool {
        (leftBottom?.text.isEmpty == false) || (rightBottom?.text.isEmpty == false)
    }
    
    private var foregroundColor: Color {
        isError ? .errorText : .textBody
    }
    
    private var backgroundColor: Color {
        isError ? .errorBackground : .backgroundWhite
    }
    
    private var strokeColor: Color {
        if focusedField.binding.wrappedValue == focusedField.equals {
            return isError ? .errorMain : .primary500
        } else {
            return isError ? .errorMain : .dividerGrey
        }
    }
    
    private var captionColor: Color {
        focusedField.binding.wrappedValue == focusedField.equals ? .textSecondary : .textTertiary
    }
}
