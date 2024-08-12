import SwiftUI

extension Entity.UI {
    public struct BottomText: Equatable {
        public let text: String
        public let textColor: Color
        
        public init(text: String, textColor: Color) {
            self.text = text
            self.textColor = textColor
        }
    }
}
