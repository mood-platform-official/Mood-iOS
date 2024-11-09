import SwiftUI

extension View {
    public func shadowSm() -> some View {
        return self
            .shadow(color: Color.black.opacity(0.08), radius: 2, x: 0, y: 1)
    }
    
    public func shadowMd() -> some View {
        self
            .shadow(color: Color.black.opacity(0.10), radius: 6, x: 0, y: 4)
            .shadow(color: Color.black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
    
    public func shadowLg() -> some View {
        self
            .shadow(color: Color.black.opacity(0.10), radius: 15, x: 0, y: 10)
            .shadow(color: Color.black.opacity(0.05), radius: 6, x: 0, y: 4)
    }
    
    public func shadowXl() -> some View {
        self
            .shadow(color: Color.black.opacity(0.10), radius: 25, x: 0, y: 20)
            .shadow(color: Color.black.opacity(0.04), radius: 10, x: 0, y: 10)
    }
    
    public func shadow2xl() -> some View {
        self
            .shadow(color: Color.black.opacity(0.25), radius: 50, x: 0, y: 25)
    }
}
