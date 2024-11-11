import SwiftUI

extension Entity.UI {
    public struct BottomText: Equatable {
        public let text: String
        public let defaultColor: Color
        
        public init(text: String, defaultColor: Color) {
            self.text = text
            self.defaultColor = defaultColor
        }
    }
}
