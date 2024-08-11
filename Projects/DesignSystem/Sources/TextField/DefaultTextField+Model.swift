import SwiftUI

extension DefaultTextField {
    public struct BottomText {
        let text: String
        let textColor: Color
        
        public init(text: String, textColor: Color) {
            self.text = text
            self.textColor = textColor
        }
    }

    public struct RightButton {
        let text: String
        let textColor: Color
        let action: () -> Void
        
        public init(text: String, textColor: Color, action: @escaping () -> Void) {
            self.text = text
            self.textColor = textColor
            self.action = action
        }
    }
}
