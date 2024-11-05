import SwiftUI
import NukeUI

public enum ProfileCardState {
    case `default`(url: String)
    case add
    case delete(url: String)
    case disabled(url: String)
}

public enum ProfileCardSize {
    case small
    case regular
    case large
}

public struct ProfileCard: View {
    let state: ProfileCardState
    let size: ProfileCardSize
    
    private var _size: CGSize {
        switch size {
        case .small: .init(width: 24, height: 24)
        case .regular: .init(width: 32, height: 32)
        case .large: .init(width: 40, height: 40)
        }
    }
    
    private var cornerRadius: CGFloat {
        switch size {
        case .small: 8
        case .regular: 12
        case .large: 12
        }
    }
    
    public init(state: ProfileCardState, size: ProfileCardSize = .regular) {
        self.state = state
        self.size = size
    }
    
    public var body: some View {
        switch state {
        case .default(let url):
            LazyImage(source: url) { state in
                if let image = state.image {
                    image.resizingMode(.center)
                        .frame(width: _size.width, height: _size.height)
                } else {
                    puppyCard()
                }
            }
        case .add:
            addIcon()
        case .delete(let url):
            LazyImage(source: url) { state in
                if let image = state.image {
                    image.resizingMode(.center)
                        .frame(width: _size.width, height: _size.height)
                        .overlay(.ultraThinMaterial)
                } else {
                    deletePuppyCard()
                }
            }
        case .disabled(let url):
            LazyImage(source: url) { state in
                if let image = state.image {
                    image.resizingMode(.center)
                        .frame(width: _size.width, height: _size.height)
                } else {
                    disabledPuppyCard()
                }
            }
        }
        
    }
}

extension ProfileCard {
    @ViewBuilder
    private func puppyCard() -> some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(Color.primary200)
            .stroke(Color.primary300, lineWidth: 2)
            .frame(width: _size.width, height: _size.height)
            .overlay {
                Text("🐶")
            }
    }
    
    @ViewBuilder
    private func addIcon() -> some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(Color.primary50)
            .stroke(Color.primary200, style: StrokeStyle(lineWidth: 2, dash: [4]))
            .frame(width: _size.width, height: _size.height)
            .overlay {
                Image(.plus)
                    .resizable()
                    .renderingMode(.template)
                    .frame(width: 16, height: 16)
                    .foregroundStyle(Color.primary400)
            }
    }
    
    @ViewBuilder
    private func deletePuppyCard() -> some View {
        let xImageSize: CGFloat = size == .large ? 24 : 16
        puppyCard()
            .overlay {
                ZStack {
                    Color.black.opacity(0.5)
                        .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
                    
                    Image(.x)
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: xImageSize, height: xImageSize)
                        .foregroundStyle(Color.white)
                }
            }
    }
    
    @ViewBuilder
    private func disabledPuppyCard() -> some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(Color.backgroundGrey)
            .stroke(Color.dividerGrey, lineWidth: 2)
            .frame(width: _size.width, height: _size.height)
            .overlay {
                Text("🐶")
            }
            .overlay {
                Color.black.opacity(0.3)
                    .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
            }
    }
}
