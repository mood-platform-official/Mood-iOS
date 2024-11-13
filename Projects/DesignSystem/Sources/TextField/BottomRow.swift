import Entity
import SwiftUI

struct BottomRow: View {
    private var leftBottom: Entity.UI.BottomText?
    private var rightBottom: Entity.UI.BottomText?
    @Binding private var isError: Bool
    @Binding private var isSuccess: Bool
    
    init(
        leftBottom: Entity.UI.BottomText? = nil,
        rightBottom: Entity.UI.BottomText? = nil,
        isError: Binding<Bool> = .constant(false),
        isSuccess: Binding<Bool> = .constant(false)
    ) {
        self.leftBottom = leftBottom
        self.rightBottom = rightBottom
        self._isError = isError
        self._isSuccess = isSuccess
    }
    
    private func color(for textItem: Entity.UI.BottomText?) -> Color {
        if isError {
            return .errorText
        } else if isSuccess {
            return .successText
        } else {
            return textItem?.defaultColor ?? .textSecondary
        }
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            if let leftBottom {
                Text(leftBottom.text)
                    .foregroundColor(color(for: leftBottom))
                    .multilineTextAlignment(.leading)
            }
            
            Spacer()
            
            if let rightBottom  {
                Text(rightBottom.text)
                    .foregroundColor(color(for: rightBottom))
                    .multilineTextAlignment(.trailing)
            }
        }
        .body3()
    }
}
