import SwiftUI

extension Entity.UI {
    public struct RightButton {
        public let text: String
        public let textColor: Color
        public let isEnabled: Bool
        public let action: () -> Void
        
        public init(text: String, textColor: Color, isEnabled: Bool = true, action: @escaping () -> Void) {
            self.text = text
            self.textColor = textColor
            self.isEnabled = isEnabled
            self.action = action
        }
    }
}
