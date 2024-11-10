import SwiftUI

public enum SolidButtonStyle {
    case primary
    case white
    case red
    
    var backgroundColor: Color {
        switch self {
        case .primary: return .primary500
        case .white: return .white
        case .red: return .errorBackground
        }
    }
    
    var foregroundColor: Color {
        switch self {
        case .primary: return .white
        case .white: return .textHeading
        case .red: return .errorText
        }
    }
    
    var loadingBackgroundColor: Color {
        switch self {
        case .primary: return .primary600
        case .white: return .grey200
        case .red: return .errorMain
        }
    }
    
    var loadingForegroundColor: Color {
        switch self {
        case .primary: return .white
        case .white: return .textHeading
        case .red: return .white
        }
    }
    
    var disabledBackgroundColor: Color {
        .dividerGrey
    }
    
    var disabledForegroundColor: Color {
        .textDisabled
    }
}


public enum OutlinedButtonStyle {
    case grey
    case primary
    case ghost
    
    var backgroundColor: Color {
        .clear
    }
    
    var foregroundColor: Color {
        switch self {
        case .grey: return .textHeading
        case .primary: return .primary500
        case .ghost: return .textHeading
        }
    }
    
    var loadingBackgroundColor: Color {
        switch self {
        case .grey: return .backgroundGrey
        case .primary: return .primary50
        case .ghost: return .backgroundGrey
        }
    }
    
    var disabledBackgroundColor: Color {
        .dividerGrey
    }
    
    var disabledForegroundColor: Color {
        .textDisabled
    }
    
    var strokeColor: Color {
        switch self {
        case .grey: return .dividerGrey
        case .primary: return .primary500
        case .ghost: return .clear
        }
    }
}
