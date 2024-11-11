import SwiftUI

extension Entity.UI {
    public struct RightButton {
        public let text: String
        public let defaultColor: Color
        public let image: Image?
        public let isEnabled: Bool
        public let action: () -> Void
        
        public init(text: String, defaultColor: Color, image: Image? = nil, isEnabled: Bool = true, action: @escaping () -> Void) {
            self.text = text
            self.defaultColor = defaultColor
            self.image = image
            self.isEnabled = isEnabled
            self.action = action
        }
    }
}
