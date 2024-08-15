import DesignSystem
import Base
import SwiftUI

// MARK: LoginView

struct LoginView: IntentBindingType {
    @StateObject var container: Container<LoginIntentType, LoginModel.State>
    var intent: LoginIntentType { self.container.intent }
    var state: LoginModel.State { self.intent.state }
    
    @Environment(\.dismiss) private var dismiss
    
    @FocusState var focusField: LoginModel.FocusField?
}

// MARK: Body

extension LoginView: View {
    
    var body: some View {
        VStack(alignment: .center, spacing: 28) {
            HStack {
                Text("비밀번호를 입력하고\n로그인해주세요")
                    .headline7(.bold)
                    .multilineTextAlignment(.leading)
                    
                Spacer()
            }
            .padding(.top, 28)
            
            VStack(spacing: 12) {
                passwordTextFieldRow()
                
                SolidButton(
                    text: "로그인",
                    disabled: state.isDisabledLoginBtn,
                    action: { self.intent.send(action: .loginBtnDidTap) }
                )
            }
            
            Button {
                self.intent.send(action: .findPWBtnDidTap)
            } label: {
                Text("비밀번호 찾기")
                    .caption1()
                    .foregroundStyle(Color.gray600)
            }
        }
        .padding(.horizontal, 16)
        .backTopBar(title: "", backAction: { self.dismiss() })
        .task {
            self.intent.send(action: .onAppear)
        }
    }
}

extension LoginView {
    @ViewBuilder
    func passwordTextFieldRow() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("비밀번호")
                .subtitle5(.medium)
                .foregroundStyle(Color.gray600)
            
            DefaultTextField(
                isSecure: true,
                placeholder: "비밀번호를 입력해주세요",
                text: .init(
                    get: { state.password },
                    set: { intent.send(action: .changePassword($0)) }
                ),
                focusedField: ($focusField, LoginModel.FocusField.password),
                disabled: false,
                isError: .init(
                    get: { state.isDisabledLoginBtn },
                    set: { _ in }
                ),
                leftBottom: .init(
                    text: state.bottomText,
                    textColor: .rubyRed
                )
            )
        }
    }
}
