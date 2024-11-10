import SwiftUI

public enum ButtonSize {
    case xs, sm, base, l, xl
    
    var hPadding: CGFloat {
        switch self {
        case .xs: return 8
        case .sm: return 12
        case .base: return 20
        case .l: return 20
        case .xl: return 24
        }
    }
    
    var vPadding: CGFloat {
        switch self {
        case .xs: return 4
        case .sm: return 8
        case .base: return 10
        case .l: return 12
        case .xl: return 14
        }
    }
    
    var iconSize: CGSize {
        switch self {
        case .xs: return CGSize(width: 12, height: 12)
        case .sm: return CGSize(width: 16, height: 16)
        case .base: return CGSize(width: 20, height: 20)
        case .l: return CGSize(width: 24, height: 24)
        case .xl: return CGSize(width: 24, height: 24)
        }
    }
    
    func applyFont<Content: View>(to content: Content) -> some View {
        switch self {
        case .xs:
            return AnyView(content.caption2())
        case .sm, .base:
            return AnyView(content.body3())
        case .l:
            return AnyView(content.subtitle3(.medium))
        case .xl:
            return AnyView(content.subtitle3(.bold))
        }
    }
}
