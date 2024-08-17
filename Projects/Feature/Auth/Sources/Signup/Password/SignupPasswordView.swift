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
        VStack(alignment: .leading, spacing: 28) {
            titleRow()
            
            pwTextFieldRow()
            pwAgainTextFieldRow()
            
            Spacer()
            
            SolidButton(
                text: "다음",
                disabled: self.state.isDisabledNextBtn,
                action: { self.intent.send(action: .nextBtnDidTap) }
            )
                .padding(.bottom, 8)
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
    func titleRow() -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("사용할 비밀번호를 입력해주세요")
                .headline7(.bold)
                .multilineTextAlignment(.leading)
            
            Text("영문 대소문자, 숫자, 특수문자를 포함해\n8자 이상으로 작성해주세요.")
                .body2()
                .foregroundStyle(Color.gray600)
                .multilineTextAlignment(.leading)
        }
    }
    
    @ViewBuilder
    func pwTextFieldRow() -> some View {
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
                isSecure: true,
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

