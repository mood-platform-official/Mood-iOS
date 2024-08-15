import DesignSystem
import Base
import SwiftUI

// MARK: SignupPasswordView

struct SignupPasswordView: IntentBindingType {
    @StateObject var container: Container<SignupPasswordIntentType, SignupPasswordModel.State>
    var intent: SignupPasswordIntentType { self.container.intent }
    var state: SignupPasswordModel.State { self.intent.state }
    
    @Environment(\.dismiss) private var dismiss
    
    @FocusState var focusField: SignupPasswordModel.FocusField?
}

// MARK: Body

extension SignupPasswordView: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            
        }
        .padding(.horizontal, 16)
        .backTopBar(title: "회원가입", backAction: { self.dismiss() })
        .task {
            self.intent.send(action: .onAppear)
        }
    }
}

extension SignupPasswordView {
    @ViewBuilder
    func pwTextFieldRow() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("비밀번호")
                .subtitle5(.medium)
                .foregroundStyle(Color.gray600)
            
            DefaultTextField(
                placeholder: "비밀번호를 입력해주세요",
                text: .init(
                    get: { state.password },
                    set: { intent.send(action: .changePassword($0)) }
                ),
                focusedField: ($focusField, SignupPasswordModel.FocusField.password),
                leftBottom: .init(
                    text: state.pwBottomText,
                    textColor: .rubyRed
                )
            )
            .keyboardType(.numberPad)
        }
    }
    
    @ViewBuilder
    func pwAgainTextFieldRow() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("비밀번호 확인")
                .subtitle5(.medium)
                .foregroundStyle(Color.gray600)
            
            DefaultTextField(
                placeholder: "비밀번호를 한번 더 입력해주세요",
                text: .init(
                    get: { state.passwordAgain },
                    set: { intent.send(action: .changePasswordAgain($0)) }
                ),
                focusedField: ($focusField, SignupPasswordModel.FocusField.passwordAgain),
                leftBottom: .init(
                    text: state.pwAgainBottomText,
                    textColor: .rubyRed
                )
            )
        }
    }
}

