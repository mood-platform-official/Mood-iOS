import SwiftUI

extension DefaultTextField {
    struct BottomRow: View {
        var leftBottom: BottomText?
        var rightBottom: BottomText?
        
        init(_ leftBottom: BottomText? = nil, _ rightBottom: BottomText? = nil) {
            self.leftBottom = leftBottom
            self.rightBottom = rightBottom
        }
        
        var body: some View {
            HStack(spacing: 0) {
                if let leftBottom {
                    Text(leftBottom.text)
                        .foregroundStyle(leftBottom.textColor)
                        .multilineTextAlignment(.leading)
                }
                
                Spacer()
                
                if let rightBottom {
                    Text(rightBottom.text)
                        .foregroundStyle(rightBottom.textColor)
                        .multilineTextAlignment(.trailing)
                }
            }
            .caption1()
            .padding(.horizontal, 12)
        }
    }
}
