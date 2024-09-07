import DesignSystem
import Base
import SwiftUI

// MARK: FindPasswordView

struct FindPasswordView: IntentBindingType {
    @StateObject var container: Container<FindPasswordIntentType, FindPasswordModel.State>
    var intent: FindPasswordIntentType { self.container.intent }
    var state: FindPasswordModel.State { self.intent.state }

    @Environment(\.dismiss) private var dismiss

    @FocusState var focusField: FindPasswordModel.FocusField?
}

// MARK: Body

extension FindPasswordView: View {

    var body: some View {
        VStack(alignment: .leading, spacing: 32) {
            HStack {
                Text("가입한 휴대폰 번호와\n이메일을 입력해주세요.")
                    .headline7(.bold)
                    .multilineTextAlignment(.leading)

                Spacer()
            }
            .padding(.top, 16)

            VStack(spacing: 12) {
                phoneTextFieldRow()
                emailTextFieldRow()

                SolidButton(
                    text: "이메일 찾기",
                    disabled: state.isDisabledAuthenticationNumberBtn,
                    action: { self.intent.send(action: .authenticationNumberBtnDidTap) }
                )
            }
        }
        .padding(.horizontal, 16)
        .backTopBar(title: "비밀번호 찾기", backAction: { self.dismiss() })
        .task {
            self.intent.send(action: .onAppear)
        }
    }
}

extension FindPasswordView {
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
                focusedField: ($focusField, FindPasswordModel.FocusField.phone),
                leftBottom: .init(
                    text: state.bottomText,
                    textColor: .rubyRed
                )
            )
            .keyboardType(.numberPad)
        }
    }

    @ViewBuilder
    func emailTextFieldRow() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("이메일")
                .subtitle5(.medium)
                .foregroundStyle(Color.gray600)

            DefaultTextField(
                placeholder: "가입한 이메일을 입력해주세요.",
                text: .init(
                    get: { state.email },
                    set: { intent.send(action: .changeEmail($0)) }
                ),
                focusedField: ($focusField, FindPasswordModel.FocusField.phone),
                leftBottom: .init(
                    text: state.bottomText,
                    textColor: .rubyRed
                )
            )
        }
    }
}
