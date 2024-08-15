import DesignSystem
import Base
import SwiftUI

// MARK: SignupETCView

struct SignupETCView: IntentBindingType {
    @StateObject var container: Container<SignupETCIntentType, SignupETCModel.State>
    var intent: SignupETCIntentType { self.container.intent }
    var state: SignupETCModel.State { self.intent.state }
    
    @Environment(\.dismiss) private var dismiss
    
    @FocusState var focusField: SignupETCModel.FocusField?
}

// MARK: Body

extension SignupETCView: View {
    
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

extension SignupETCView {
    @ViewBuilder
    func nameTextFieldRow() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("이름")
                .subtitle5(.medium)
                .foregroundStyle(Color.gray600)
            
            DefaultTextField(
                placeholder: "비밀번호를 입력해주세요",
                text: .init(
                    get: { state.name },
                    set: { intent.send(action: .changeName($0)) }
                ),
                focusedField: ($focusField, SignupETCModel.FocusField.name)
            )
            .keyboardType(.numberPad)
        }
    }
    
    @ViewBuilder
    func birthDayTextFieldRow() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("생년월일")
                .subtitle5(.medium)
                .foregroundStyle(Color.gray600)
            
            DefaultTextField(
                placeholder: "YYYY.MM.DD",
                text: .init(
                    get: { state.birthDay },
                    set: { intent.send(action: .changeBirthDay($0)) }
                ),
                focusedField: ($focusField, SignupETCModel.FocusField.birthDay)
            )
        }
    }
    
    @ViewBuilder
    func nicknameTextFieldRow() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("닉네임")
                .subtitle5(.medium)
                .foregroundStyle(Color.gray600)
            
            DefaultTextField(
                placeholder: "별명을 입력해주세요",
                text: .init(
                    get: { state.nickname },
                    set: { intent.send(action: .changeNickname($0)) }
                ),
                focusedField: ($focusField, SignupETCModel.FocusField.nickname)
            )
        }
    }
}
