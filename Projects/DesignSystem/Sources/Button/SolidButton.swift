import SwiftUI

public struct SolidButton: View {
    var size: ButtonSize
    var style: SolidButtonStyle
    var maxWidth: CGFloat?
    var text: String
    var leftIcon: Image?
    var rightIcon: Image?
    var loadingIcon: Image?
    var disabled: Bool
    var action: () -> Void
    
    @State private var isLoading = false
    
    private var foregroundColor: Color { isLoading ? style.loadingForegroundColor : (disabled ? style.disabledForegroundColor : style.foregroundColor) }
    private var backgroundColor: Color { isLoading ? style.loadingBackgroundColor : (disabled ? style.disabledBackgroundColor : style.backgroundColor) }
    private var iconSize: CGSize { size.iconSize }
    
    public init(
        size: ButtonSize = .base,
        style: SolidButtonStyle = .primary,
        maxWidth: CGFloat? = .infinity,
        text: String,
        leftIcon: Image? = nil,
        rightIcon: Image? = nil,
        loadingIcon: Image? = nil,
        disabled: Bool = false,
        action: @escaping () -> Void
    ) {
        self.size = size
        self.style = style
        self.maxWidth = maxWidth
        self.text = text
        self.leftIcon = leftIcon
        self.rightIcon = rightIcon
        self.loadingIcon = loadingIcon
        self.disabled = disabled
        self.action = action
    }
    
    public var body: some View {
        Button {
            performAction()
        } label: {
            HStack(alignment: .center, spacing: 8) {
                iconView(icon: leftIcon, size: iconSize, color: foregroundColor)
                
                size.applyFont(to: Text(text))
                    .foregroundStyle(foregroundColor)
                
                if isLoading {
                    iconView(icon: loadingIcon, size: iconSize, color: foregroundColor)
                } else {
                    iconView(icon: rightIcon, size: iconSize, color: foregroundColor)
                    
                }
            }
            .padding(.horizontal, size.hPadding)
            .padding(.vertical, size.vPadding)
            .frame(maxWidth: maxWidth)
        }
        .background(backgroundColor)
        .clipShape(Capsule())
        .disabled(disabled || isLoading)
    }
    
    private func performAction() {
        guard !isLoading else { return }
        withAnimation {
            isLoading = true
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.action()
            
            DispatchQueue.main.async {
                withAnimation {
                    isLoading = false
                }
            }
        }
    }
}

extension SolidButton {
    @ViewBuilder
    func iconView(icon: Image?, size: CGSize, color: Color) -> some View {
        if let icon = icon {
            icon
                .resizable()
                .renderingMode(.template)
                .frame(width: size.width, height: size.height)
                .foregroundStyle(color)
        } else {
            EmptyView()
        }
    }
}
