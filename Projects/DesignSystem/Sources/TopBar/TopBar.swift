import SwiftUI

struct TopBarModifier<Left, Right>: ViewModifier where Left: View, Right: View {
    var title: String?
    var padding: (Edge.Set, CGFloat?)
    var leftItem: (() -> Left)?
    var rightItem: (() -> Right)?
    
    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            TopBar(
                title: self.title,
                padding: self.padding,
                leftItem: self.leftItem,
                rightItem: self.rightItem
            )
            .zIndex(999)
            content
                .frame(maxHeight: .infinity, alignment: .top)
        }
        .navigationBarHidden(true)
    }
}

struct TopBar<Left, Right>: View where Left: View, Right: View {
    var title: String?
    var padding: (Edge.Set, CGFloat?)
    var leftItem: (() -> Left)?
    var rightItem: (() -> Right)?
    
    var body: some View {
        HStack {
            self.leftItem?()
            if let title {
                Text(title)
                    .subtitle3(.medium)
                    .padding(.horizontal, 16)
            }
            Spacer()
            self.rightItem?()
        }
        .padding(padding.0, padding.1)
        .frame(height: 56)
        .background(Color.clear.ignoresSafeArea())
    }
}

extension View {
    public func topBar<Left: View, Right: View>(
        title: String,
        padding: (Edge.Set, CGFloat?) = (.horizontal, 16),
        @ViewBuilder leftItem: @escaping () -> Left,
        @ViewBuilder rightItem: @escaping () -> Right
    ) -> some View {
        modifier(
            TopBarModifier(
                title: title,
                padding: padding,
                leftItem: leftItem,
                rightItem: rightItem
            )
        )
    }
    
    public func backTopBar(
        title: String,
        padding: (Edge.Set, CGFloat?) = (.horizontal, 16),
        backAction: @escaping () -> Void
    ) -> some View {
        modifier(
            TopBarModifier(
                title: title,
                padding: padding,
                leftItem: { self.backButton(backAction: backAction) },
                rightItem: { EmptyView() }
            )
        )
    }
    
    public func searchTopBar<value:Hashable>(
        title: String? = nil,
        padding: (Edge.Set, CGFloat?) = (.horizontal, 16),
        backAction: @escaping () -> Void,
        text: Binding<String>,
        placeholder: String = "지금 나의 무드와 맞는 모임은?",
        focusedField: (binding: FocusState<value?>.Binding, equals: value?)
    ) -> some View {
        modifier(
            TopBarModifier(
                title: title,
                padding: padding,
                leftItem: { self.backButton(backAction: backAction) },
                rightItem: {
                    DefaultTextField(
                        size: .small,
                        isSecure: false,
                        placeholder: placeholder,
                        text: text,
                        focusedField: focusedField
                    )
                    .padding(.leading, 12)
                }
            )
        )
    }
    
    private func backButton(backAction: @escaping () -> Void) -> some View {
        Button(action: backAction) {
            Image.arrowLeft
                .resizable()
                .frame(width: 24, height: 24)
        }
    }
}
