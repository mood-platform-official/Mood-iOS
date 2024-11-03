import SwiftUI

enum TooltipState {
    case `default`
    case primary
}

struct TooltipModifier: ViewModifier {
    let text: String
    let alignment: Edge
    let state: TooltipState
    @Binding var isVisible: Bool
    
    func body(content: Content) -> some View {
        content
            .overlay {
                TooltipView(text: text, state: state, alignment: alignment, isVisible: $isVisible)
            }
    }
}

struct TooltipView: View {
    let text: String
    let state: TooltipState
    let alignment: Edge
    @Binding var isVisible: Bool
    let arrowOffset = CGFloat(8)
    
    private var oppositeAlignment: Alignment {
        let result: Alignment
        switch alignment {
        case .top: result = .bottom
        case .bottom: result = .top
        case .leading: result = .trailing
        case .trailing: result = .leading
        }
        return result
    }
    
    private var bgColor: Color {
        switch state {
        case .default: Color.white
        case .primary: Color.primary500
        }
    }
    
    private var textColor: Color {
        switch state {
        case .default: Color.textHeading
        case .primary: Color.grey100
        }
    }

    var body: some View {
        if isVisible {
            GeometryReader { proxy1 in
                theHint
                    .hidden()
                    .overlay {
                        GeometryReader { proxy2 in
                            theHint
                                .drawingGroup()
                                .shadow(radius: 4)
                                .offset(
                                    x: -(proxy2.size.width / 2) + (proxy1.size.width / 2),
                                    y: -(proxy2.size.height / 2) + (proxy1.size.height / 2)
                                )
                                .offset(x: alignment == .leading ? (-proxy2.size.width / 2) - (proxy1.size.width / 2) : 0)
                                .offset(x: alignment == .trailing ? (proxy2.size.width / 2) + (proxy1.size.width / 2) : 0)
                                .offset(y: alignment == .top ? (-proxy2.size.height / 2) - (proxy1.size.height / 2) : 0)
                                .offset(y: alignment == .bottom ? (proxy2.size.height / 2) + (proxy1.size.height / 2) : 0)
                        }
                    }
            }
            .onTapGesture {
                isVisible.toggle()
            }
        }
    }
}

extension TooltipView {
    private var theHint: some View {
        Text(text)
            .body3()
            .padding(.horizontal, 12)
            .padding(.vertical, 5)
            .background(bgColor)
            .foregroundColor(textColor)
            .cornerRadius(4)
            .background(alignment: oppositeAlignment) {
                Rectangle()
                    .fill(bgColor)
                    .frame(width: 16, height: 16)
                    .rotationEffect(.degrees(45))
                    .offset(x: alignment == .leading ? arrowOffset : 0)
                    .offset(x: alignment == .trailing ? -arrowOffset : 0)
                    .offset(y: alignment == .top ? arrowOffset : 0)
                    .offset(y: alignment == .bottom ? -arrowOffset : 0)
            }
            .padding()
            .fixedSize()
    }
}
