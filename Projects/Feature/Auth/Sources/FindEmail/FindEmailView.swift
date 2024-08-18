import DesignSystem
import Base
import SwiftUI

// MARK: FindEmailView

struct FindEmailView: IntentBindingType {
    @StateObject var container: Container<FindEmailIntentType, FindEmailModel.State>
    var intent: FindEmailIntentType { self.container.intent }
    var state: FindEmailModel.State { self.intent.state }
    
    @Environment(\.dismiss) private var dismiss
    
    @FocusState var focusField: FindEmailModel.FocusField?
}

// MARK: Body

extension FindEmailView: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            Text("비밀번호를 입력하고\n로그인해주세요")
                .headline7(.bold)
                .multilineTextAlignment(.leading)
                .padding(.top, 16)
            
            VStack(spacing: 12) {
                phoneTextFieldRow()
                
                SolidButton(
                    text: "이메일 찾기",
                    disabled: !state.isEnabledFindEmailBtn,
                    action: { self.intent.send(action: .findEmailBtnDidTap) }
                )
            }
        }
        .padding(.horizontal, 16)
        .backTopBar(title: "이메일 찾기", backAction: { self.dismiss() })
        .task {
            self.intent.send(action: .onAppear)
        }
    }
}

extension FindEmailView {
    @ViewBuilder
    func phoneTextFieldRow() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("휴대폰 번호")
                .subtitle5(.medium)
                .foregroundStyle(Color.gray600)
            
            DefaultTextField(
                placeholder: "01012345678",
                text: .init(
                    get: { state.phoneNumber },
                    set: { intent.send(action: .changePhoneNumber($0)) }
                ),
                focusedField: ($focusField, FindEmailModel.FocusField.phone),
                disabled: false,
                isError: .init(
                    get: { !state.bottomText.isEmpty },
                    set: { _ in }
                ),
                leftBottom: .init(
                    text: state.bottomText,
                    textColor: .rubyRed
                )
            )
            .keyboardType(.numberPad)
            .onSubmit {
                intent.send(action: .onSubmitPhoneNumber)
            }
        }
    }
}
