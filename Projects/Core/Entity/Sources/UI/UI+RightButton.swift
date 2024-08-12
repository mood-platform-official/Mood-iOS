import SwiftUI

extension Entity.UI {
    public struct RightButton {
        public let text: String
        public let textColor: Color
        public let action: () -> Void
        
        public init(text: String, textColor: Color, action: @escaping () -> Void) {
            self.text = text
            self.textColor = textColor
            self.action = action
        }
    }
}
