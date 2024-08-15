import DesignSystem
import Base
import SwiftUI

// MARK: SignupPhoneAuthView

struct SignupPhoneAuthView: IntentBindingType {
    @StateObject var container: Container<SignupPhoneAuthIntentType, SignupPhoneAuthModel.State>
    var intent: SignupPhoneAuthIntentType { self.container.intent }
    var state: SignupPhoneAuthModel.State { self.intent.state }
    
    @Environment(\.dismiss) private var dismiss
    
    @FocusState var focusField: SignupPhoneAuthModel.FocusField?
}

// MARK: Body

extension SignupPhoneAuthView: View {
    
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

extension SignupPhoneAuthView {
    @ViewBuilder
    func phoneNumberTextFieldRow() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("이름")
                .subtitle5(.medium)
                .foregroundStyle(Color.gray600)
            
            DefaultTextField(
                placeholder: "비밀번호를 입력해주세요",
                text: .init(
                    get: { state.phoneNumber },
                    set: { intent.send(action: .changePhoneNumber($0)) }
                ),
                focusedField: ($focusField, SignupPhoneAuthModel.FocusField.phoneNumber)
            )
            .keyboardType(.numberPad)
        }
    }
}
