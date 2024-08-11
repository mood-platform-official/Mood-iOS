import SwiftUI

extension DefaultTextField {
    struct TextFieldRow: View {
        let placeholder: String
        @Binding var text: String
        var bgColor: Color
        var strokeColor: Color
        var rightBtn: RightButton?
        
        init(_ placeholder: String, _ text: Binding<String>, _ bgColor: Color, _ strokeColor: Color, _ rightBtn: RightButton? = nil) {
            self.placeholder = placeholder
            self._text = text
            self.bgColor = bgColor
            self.strokeColor = strokeColor
            self.rightBtn = rightBtn
        }
        
        var body: some View {
            HStack(spacing: 8) {
                TextField(placeholder, text: $text)
                    
                if let rightBtn {
                    Button {
                        rightBtn.action()
                    } label: {
                        Text(rightBtn.text)
                            .foregroundStyle(rightBtn.textColor)
                    }
                }
            }
            .body1()
            .padding(.horizontal, 16)
            .padding(.vertical, 11)
            .background {
                RoundedRectangle(cornerRadius: 12)
                    .fill(bgColor)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(strokeColor, lineWidth: 1.0)
            )
        }
    }
}
