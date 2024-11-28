import SwiftUI

public struct OverlayLine: View {
    var height: CGFloat
    var bgColor: Color
    var tintColor: Color
    var divideBy: CGFloat
    
    public init(height: CGFloat = 4, bgColor: Color = .dividerGrey, tintColor: Color = .primary500, divideBy: CGFloat) {
        self.height = height
        self.bgColor = bgColor
        self.tintColor = tintColor
        self.divideBy = divideBy
    }
    
    public var body: some View {
        GeometryReader { geometry in
            Line()
                .frame(height: height)
                .background(bgColor)
                .overlay(alignment: .leading) {
                    Line()
                        .frame(width: geometry.size.width / divideBy, height: height)
                        .background(tintColor)
                }
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}
