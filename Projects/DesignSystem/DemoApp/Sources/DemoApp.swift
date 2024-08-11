import SwiftUI
import DesignSystem


enum FocusField {
    case one
    case two
    case three
}

@main
struct AuthApp: App {
    
    @State var text1: String = ""
    @State var text2: String = ""
    @State var text3: String = ""
    @State var text4: String = ""
    @FocusState var focusField: FocusField?
    @State var isError1: Bool = false
    @State var isError2: Bool = false
    @State var isError3: Bool = true
    
    var body: some Scene {
        WindowGroup {
            VStack(spacing: 20) {
                DefaultTextField(
                    placeholder: "1",
                    text: $text1,
                    focusedField: ($focusField, FocusField.one),
                    disabled: false,
                    isError: $isError1,
                    leftBottom: .init(text: "123", textColor: .primary500),
                    rightBottom: .init(text: "456", textColor: .primary500),
                    rightBtn: .init(text: "789", textColor: .primary500, action: {
                        
                    })
                )
                
                DefaultTextField(
                    placeholder: "1",
                    text: $text2,
                    focusedField: ($focusField, FocusField.two),
                    disabled: false,
                    isError: $isError2,
                    leftBottom: .init(text: "123", textColor: .primary500)
                )
                
                DefaultTextField(
                    placeholder: "1",
                    text: $text2,
                    focusedField: ($focusField, FocusField.two),
                    disabled: false,
                    isError: $isError2,
                    rightBottom: .init(text: "123", textColor: .primary500)
                )
                
                DefaultTextField(
                    placeholder: "1",
                    text: $text2,
                    focusedField: ($focusField, FocusField.two),
                    disabled: false,
                    isError: $isError2,
                    rightBtn: .init(text: "789", textColor: .primary500, action: {
                        
                    })
                )
                
                DefaultTextField(
                    placeholder: "1",
                    text: $text3,
                    focusedField: ($focusField, FocusField.three),
                    disabled: false,
                    isError: $isError3,
                    leftBottom: .init(text: "123", textColor: isError3 ? .rubyRed : .primary500),
                    rightBottom: .init(text: "456", textColor: .primary500)
                )
            }
            .padding(.horizontal, 20)
        }
    }
}
