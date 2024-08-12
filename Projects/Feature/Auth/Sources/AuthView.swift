import SwiftUI
import DesignSystem
import Base

// MARK: AccountSleepView

struct AuthView: IntentBindingType {
    @StateObject public var container: Container<AuthIntentType, AuthModel.State>
    var intent: AuthIntentType { self.container.intent }
    var state: AuthModel.State { self.intent.state }
    
    init(container: Container<AuthIntentType, AuthModel.State>) {
        self._container = StateObject(wrappedValue: container)
    }
    
    @FocusState var focusField: AuthModel.FocusField?
}

extension AuthView: View {
    var body: some View {
        VStack(spacing: 72) {
            Text("Mood")
                .headline1(.bold)
                .frame(height: 150)
                .frame(maxWidth: .infinity)
                
            VStack(alignment: .leading, spacing: 8) {
                Text("이메일")
                    .subtitle5(.medium)
                    .foregroundStyle(Color.gray600)
                
                DefaultTextField(
                    placeholder: "이메일을 입력해주세요",
                    text: .init(
                        get: { state.email },
                        set: { intent.send(action: .changeEmail($0)) }
                    ),
                    focusedField: ($focusField, AuthModel.FocusField.email),
                    disabled: false,
                    isError: .init(
                        get: { state.isError },
                        set: { intent.send(action: .changeError($0)) }
                    ),
                    leftBottom: .init(
                        text: state.bottomText,
                        textColor: .rubyRed
                    )
                )
            }
            
        }
        .padding(.horizontal, 16)
    }
}

